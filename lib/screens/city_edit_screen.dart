import 'dart:ffi';
import 'dart:ui';

import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class CityEditScreen extends StatelessWidget {
  final ApitestController apitestController = Get.put(ApitestController());
  final CityListController cityListController = Get.put(CityListController());

  @override
  Widget build(BuildContext context) {
    final sortedCitys = [...cityListController.citys];
    return Scaffold(
      appBar: AppBar(
        title: Text('Sortien / Löschen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ImplicitlyAnimatedReorderableList<dynamic>(
                items: sortedCitys,
                onReorderFinished: (item, from, to, newItems) {
                  // Remember to update the underlying data when the list has been
                  // reordered.
                  cityListController.saveCityList(newItems);
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
                            cityListController
                                .toggleCityToList(sortedCitys[index]);
                          },
                          child: Card(
                            color: color,
                            elevation: elevation,
                            child: Material(
                              type: MaterialType.transparency,
                              child: ListTile(
                                title: Text(item),
                                // The child of a Handle can initialize a drag/reorder.
                                // This could for example be an Icon or the whole item itself. You can
                                // use the delay parameter to specify the duration for how long a pointer
                                // must press the child, until it can be dragged.
                                enableFeedback: true,
                                leading: Handle(
                                  delay: const Duration(milliseconds: 0),
                                  child: Icon(
                                    Icons.unfold_more,
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
                          Icon(Icons.delete,
                              color: Theme.of(context).highlightColor),
                          Text(
                            'Löschen: Landkreis zur Seite wischen',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor),
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
