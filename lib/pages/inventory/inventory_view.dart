import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/pages/inventory/addInventory/view.dart';

import '../../components/inventory_widget.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Column(
              children: [
                InventoryWidget(
                  title: 'Add',
                  icon: Icons.add,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {
                    Get.to(AddItemView());
                  },
                ),
                InventoryWidget(
                  title: 'Edit',
                  icon: Icons.edit,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {},
                ),
                InventoryWidget(
                  title: 'Discounted Items',
                  icon: Icons.discount_outlined,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
