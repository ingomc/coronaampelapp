import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:coronampel/controller/get_countys_controller.dart';
import 'package:coronampel/controller/pinned_countys_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:matomo/matomo.dart';

class CountyEditScreen extends TraceableStatelessWidget {
  final PinnedCountysController pinnedCountysController =
      Get.put(PinnedCountysController());
  final GetCountysController getCountysController =
      Get.put(GetCountysController());

  @override
  Widget build(BuildContext context) {
    final sortedCountys = [...pinnedCountysController.countys];

    void _select(value) {
      switch (value) {
        case 'deleteall':
          pinnedCountysController.countys.assignAll([]);
          Get.back();
          Get.snackbar('Alle Landkreise entfernt',
              'Ihre Liste ist jetzt leer, fügen sie neue Landkreise über das "+"-Symbol hinzu.',
              snackPosition: SnackPosition.BOTTOM);
          break;
      }
      // print(value);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sortieren / Löschen'),
        actions: [
          PopupMenuButton(
            icon: Icon(MdiIcons.dotsVertical),
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'deleteall',
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.delete,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Alle Landkreise entfernen'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ImplicitlyAnimatedReorderableList<dynamic>(
                items: sortedCountys,
                onReorderFinished: (item, from, to, newItems) {
                  // Remember to update the underlying data when the list has been
                  // reordered.
                  pinnedCountysController.countys.assignAll(newItems);
                },
                areItemsTheSame: (a, b) => a == b,
                itemBuilder: (context, itemAnimation, item, index) {
                  // Each item must be wrapped in a Reorderable widget.
                  return Reorderable(
                    // Each item must have an unique key.
                    key: ValueKey(item),
                    // The animation of the Reorderable builder can be used to
                    // change to appearance of the item between dragged and normal
                    // state. For example to add elevation when the item is being dragged.
                    // This is not to be confused with the animation of the itemBuilder.
                    // Implicit animations (like AnimatedContainer) are sadly not yet supported.
                    builder: (context, dragAnimation, inDrag) {
                      final t = dragAnimation.value;
                      final elevation = lerpDouble(0, 8, t);
                      final color = Color.lerp(Theme.of(context).cardColor,
                          Theme.of(context).cardColor.withOpacity(0.9), t);

                      return SizeFadeTransition(
                        sizeFraction: 0.7,
                        curve: Curves.easeInOut,
                        animation: itemAnimation,
                        child: Dismissible(
                          key: ValueKey(item),
                          // background: Colors.accents,
                          onDismissed: (direction) {
                            // cityListController.citys.removeAt(index);
                            // cityListController.instantRemoveCity(index);
                            // cityListController
                            //     .toggleCityToList(sortedCitys[index]);
                            print(item);
                            sortedCountys.remove(item);
                            pinnedCountysController.toggleCounty(item);
                          },
                          child: Card(
                            color: color,
                            elevation: elevation,
                            child: Material(
                              type: MaterialType.transparency,
                              child: ListTile(
                                title: Text(
                                    '${getCountysController.countys[item].bez} ${getCountysController.countys[item].gen}'),
                                // The child of a Handle can initialize a drag/reorder.
                                // This could for example be an Icon or the whole item itself. You can
                                // use the delay parameter to specify the duration for how long a pointer
                                // must press the child, until it can be dragged.
                                enableFeedback: true,
                                trailing: Handle(
                                  delay: const Duration(milliseconds: 0),
                                  child: Icon(
                                    MdiIcons.unfoldMoreVertical,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                // Since version 0.2.0 you can also display a widget
                // before the reorderable items...
                header: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.delete,
                              color: Theme.of(context).disabledColor),
                          Text(
                            'Löschen: Landkreis zur Seite wischen',
                            style: TextStyle(
                                color: Theme.of(context).disabledColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ...and after. Note that this feature - as the list itself - is still in beta!
                footer: Container(),
                // If you want to use headers or footers, you should set shrinkWrap to true
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
