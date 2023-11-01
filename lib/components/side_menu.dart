import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/controllers/menu_controllers.dart';
import 'package:groce_zone_admin/routing/routes.dart';

import '../helpers/responsive.dart';
import 'app_colors.dart';
import 'custom_text.dart';

class SideMenu extends StatelessWidget {
  SideMenu({ Key? key }) : super(key: key);

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
            value ? controller.isHover(itemName) : controller.isHover('no hovering');
          },
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
                      child: Obx(() => Container(
                        child: Center(
                          child: Icon(
                            itemIcon,
                            size: 25,
                            color: controller.isHovering(itemName) || controller.activeItem.value == itemValue
                                ? Colors.green
                                : Colors.black.withOpacity(0.2),
                          ),),
                      ),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Obx(() => Container(
                      color: controller.isHovering(itemName)
                          ? Colors.green
                          : Colors.black.withOpacity(0.2),
                      width: 1,
                      height: double.infinity,
                    ),),
                  ),
                  Obx((){
                    return Padding(
                      padding: EdgeInsets.only(left: 10,right: 1),
                      child: Container(
                        child: Center(
                          child: Text(itemName,
                              style: TextStyle(
                                fontSize: 18,
                                color: controller.activeItem.value == itemValue || controller.hoverItem.value == itemName
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


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if(ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.logo_dev_outlined),
                    ),
                    const Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: width / 48),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(color: lightGrey.withOpacity(.1), ),

          Container(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap:() {
                          Navigator.pop(context);
    },
                        child: _sideMenuItemWidget(
                            'DashBoard', Icons.data_exploration_outlined, 'dashboard'),
                      ),
                      _sideMenuItemWidget(
                          'Inventory', Icons.inventory_rounded, 'inventory'),
                      _sideMenuItemWidget('Orders', Icons.trending_up, 'orders'),
                    ],
                  ),
                ),
                

              ],
            ),
          ),
        ],
      ),
    );
  }
}