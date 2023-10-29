import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/pages/orders/widgets/all_orders/all_orders.dart';
import 'package:groce_zone_admin/pages/orders/widgets/cancelled_orders/cancelled_orders.dart';
import 'package:groce_zone_admin/pages/orders/widgets/delivered_orders/delivered_orders.dart';
import 'package:groce_zone_admin/pages/orders/widgets/pending_orders/pending_orders.dart';
import 'package:groce_zone_admin/pages/orders/widgets/shipped_orders/shipped_orders.dart';

import '../../components/inventory_widget.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

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
                  title: 'All Orders',
                  icon: Icons.add,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {
                    print('object');
                    Get.to(() => AllOrdersView());
                    print('object1');
                  },
                ),
                InventoryWidget(
                  title: 'Pending',
                  icon: Icons.access_time_outlined,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {
                    Get.to(
                      () => PendingOrdersView(),
                    );
                  },
                ),
                InventoryWidget(
                  title: 'Shipped',
                  icon: Icons.local_shipping_outlined,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {
                    Get.to(
                      () => ShippedOrdersView(),
                    );
                  },
                ),
                InventoryWidget(
                  title: 'Delivered',
                  icon: Icons.pending_actions_outlined,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {
                    Get.to(
                      () => DeliveredOrdersView(),
                    );
                  },
                ),
                InventoryWidget(
                  title: 'Cancelled',
                  icon: Icons.cancel_outlined,
                  color: Colors.white,
                  borderColor: Colors.green,
                  onPress: () {
                    Get.to(
                      () => CancelledOrdersView(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
