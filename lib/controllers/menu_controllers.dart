import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/app_colors.dart';
import 'package:groce_zone_admin/routing/routes.dart';

class SideMenuController extends GetxController {
  static SideMenuController instance = Get.find();
  var activeItem = 'dashboard'.obs;
  var hoverItem = ''.obs;

  changePageTo(String itemName) {
    activeItem.value = itemName;
  }

  isHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIcon(String itemName) {
    switch (itemName) {
      case DashBoardPageRoute:
        return _customIcon(Icons.trending_up, itemName);
      case OrdersPageRoute:
        return _customIcon(Icons.shop_2_outlined, itemName);
      case InventoryPageRoute:
        return _customIcon(Icons.inventory_2_outlined, itemName);
      default:
        return _customIcon(Icons.trending_up, itemName);
    }
    ;
  }

  Widget _customIcon(IconData iconData, String itemName) {
    if (isActive(itemName))
      return Icon(
        iconData,
        color: dark,
        size: 20,
      );
    return Icon(
      iconData,
      color: isHovering(itemName) ? dark : lightGrey,
      size: 18,
    );
  }
}
