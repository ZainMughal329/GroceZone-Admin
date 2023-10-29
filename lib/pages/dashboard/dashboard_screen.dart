import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/controllers/menu_controllers.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  SideMenuController controller = Get.find();

  Widget _sideMenuItemWidget(
      String itemName, IconData itemIcon, String itemValue) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            controller.activeItem.value = itemValue;
          },
          onHover: (value) {
          },
          child: Flexible(
            child: Container(
              height: 40,
              // color: Colors.grey.withOpacity(0.2),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 3, left: 5),
                      child: Padding(
                        padding:  EdgeInsets.only(left: 5),
                        child: Container(
                          child: Center(
                              child: Icon(
                            itemIcon,
                            size: 25,
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                        height: double.infinity,
                      ),
                    ),
                    Obx((){
                      return Padding(
                        padding: EdgeInsets.only(left: 10,right: 1),
                        child: Container(
                          child: Center(
                            child: Text(itemName,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: controller.activeItem.value == itemValue
                                      ? Colors.green
                                      : Colors.black,
                                )),
                          ),
                        ),
                      );
                    }),
                    Flexible(child: Container()),
                  ],

                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Divider(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _itemScreen(String screen) {
    if (screen == "inventory") {
      return Container(
        child: Center(
          child: Text('Inventory Screen'),
        ),
      );
    } else if (screen == "orders") {
      return Container(
        child: Center(
          child: Text('Orders Screen'),
        ),
      );
    } else
      return Container(
        child: Center(
          child: Text('DashBoard Screen'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _sideMenuItemWidget(
                      'DashBoard', Icons.data_exploration_outlined, 'dashboard'),
                  _sideMenuItemWidget(
                      'Inventory', Icons.inventory_rounded, 'inventory'),
                  _sideMenuItemWidget('Orders', Icons.trending_up, 'orders'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
              child: Container(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
            Obx(() {
              return Expanded(
                flex: 5,
                child: Container(child: _itemScreen(controller.activeItem.value)),
              );
            })
          ],
        ),
      ),
    );
  }
}
