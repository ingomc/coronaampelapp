import 'dart:ffi';
import 'dart:ui';

import 'package:coronaampel/controller/apitest_controller.dart';
import 'package:coronaampel/controller/city_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class TestScreen extends StatelessWidget {
  final ApitestController apitestController = Get.put(ApitestController());
  final CityListController cityListController = Get.put(CityListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<ApitestController>(
                builder: (controller) {
                  return ImplicitlyAnimatedReorderableList<dynamic>(
                    items: cityListController.citys.toList(),
                    onReorderFinished: (item, from, to, newItems) {
                      // Remember to update the underlying data when the list has been
                      // reordered.
                      // setState(() {
                      //   items
                      //     ..clear()
                      //     ..addAll(newItems);
                      // });
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
                          final color = Color.lerp(
                              Colors.white, Colors.white.withOpacity(0.8), t);

                          return SizeFadeTransition(
                            sizeFraction: 0.7,
                            curve: Curves.easeInOut,
                            animation: itemAnimation,
                            child: Material(
                              color: color,
                              elevation: elevation,
                              type: MaterialType.transparency,
                              child: ListTile(
                                title: Text(item),
                                // The child of a Handle can initialize a drag/reorder.
                                // This could for example be an Icon or the whole item itself. You can
                                // use the delay parameter to specify the duration for how long a pointer
                                // must press the child, until it can be dragged.
                                trailing: Handle(
                                  delay: const Duration(milliseconds: 100),
                                  child: Icon(
                                    Icons.list,
                                    color: Colors.grey,
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
                      height: 200,
                      color: Colors.red,
                    ),
                    // ...and after. Note that this feature - as the list itself - is still in beta!
                    footer: Container(
                      height: 200,
                      color: Colors.green,
                    ),
                    // If you want to use headers or footers, you should set shrinkWrap to true
                    shrinkWrap: true,
                  );

                  // return ListView.builder(
                  //   itemCount: controller.userList.length,
                  //   itemBuilder: (context, index) {
                  //     if (controller.userList != null &&
                  //         controller.userList.length > 0) {
                  //       var test = apitestController.userList.firstWhere(
                  //           (cityItem) =>
                  //               cityItem.attributes.county ==
                  //               cityListController.citys[index],
                  //           orElse: () => null);
                  //       String cases =
                  //           ((test.attributes.cases7Per100K) as double)
                  //               .toStringAsFixed(1);
                  //       return Card(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(16.0),
                  //           child: Text(
                  //               '${cases} ${test.attributes.gen} ${test.attributes.bez}'),
                  //         ),
                  //       );
                  //     }
                  //     return Container();
                  //   },
                  // );
                },
              ),
            ),
            RaisedButton(
              onPressed: () {
                apitestController.fetchUsers(
                  cityListController.citys,
                );
              },
              child: Text('refresh'),
            )
          ],
        ),
      ),
    );
  }
}
