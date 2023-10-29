import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/pages/orders/widgets/order_items/state.dart';

import '../../../../models/orders_model.dart';

class OrderItemsController extends GetxController {
  final state = OrderItemsState();

  Future<List<OrderModel>> getAllOrdersData(String customerId,String orderId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(customerId)
        .collection('orderList')
        .where('orderId', isEqualTo: orderId)
        .get();
    final itemData = snapshot.docs.map((e) => OrderModel.fromJson(e)).toList();
    return itemData;
  }

  Future<List<OrderModel>> getAndShowALlOrdersData(String customerId,String orderId) async {
    return await getAllOrdersData(customerId,orderId);
  }
}
