import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/pages/orders/widgets/order_items/order_items.dart';
import 'package:groce_zone_admin/pages/orders/widgets/orders_detail/controller.dart';

import '../../../../helpers/responsive.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  String orderId;

  OrderDetailView({Key? key, required this.orderId}) : super(key: key);
  final controller = Get.put<OrderDetailController>(OrderDetailController());

  Widget _returnDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16.0),

          // Product or Order Icon in a Circle Avatar with shadow
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bookmark_border, size: 50, color: Colors.green),
            ),
          ),

          SizedBox(height: 15),

          // Using a card to make it pop a bit more
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    _detailText('Order #',
                        controller.orderDetails!.orderId.toString(), true),
                    _detailText('Customer Name',
                        controller.orderDetails!.name.toString()),
                    _detailText('Phone Number',
                        controller.orderDetails!.number.toString()),
                    _detailText(
                        'Address', controller.orderDetails!.address.toString()),
                    _detailText('Label',
                        controller.orderDetails!.addressLabel.toString()),
                    _detailText('Payment Method',
                        controller.orderDetails!.paymentMethod.toString()),
                    _detailText('Order Price',
                        controller.orderDetails!.orderPrice.toString()),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Status'),
                                content: Obx(() {
                                  return DropdownButton(
                                    hint: Text(controller.state.hint.value),
                                    items: <DropdownMenuItem>[
                                      DropdownMenuItem(
                                        child: Text('Pending'),
                                        value: 'pending',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Shipped'),
                                        value: 'shipped',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Delivered'),
                                        value: 'delivered',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Cancelled'),
                                        value: 'cancelled',
                                      ),
                                    ],
                                    onChanged: (value) {
                                      controller.state.hint.value = value!;
                                    },
                                  );
                                }),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Change'),
                                    onPressed: () {
                                      String uid = controller
                                          .orderDetails!.customerId
                                          .toString();
                                      controller.changeStatus(orderId, uid,
                                          controller.state.hint.value);
                                      Get.back();
                                      Get.back();
                                      Navigator.of(context).pop();
                                      // Snackbar.showSnackBar("Update", "Updated All Statuses");
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Obx(
                        () => _detailText(
                          'Status\n(tap to change)',
                          controller.state.hint.value,
                          true,
                          controller.orderDetails!.status == "pending"
                              ? Colors.orange
                              : controller.orderDetails!.status == "delivered"
                                  ? Colors.green
                                  : controller.orderDetails!.status == "shipped"
                                      ? Colors.yellow
                                      : controller.orderDetails!.status ==
                                              "cancelled"
                                          ? Colors.red
                                          : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Provide some spacing before the button

                    // Button with styling
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => OrderItemsView(
                                customerId: controller.orderDetails!.customerId,
                                orderId: orderId),
                          );
                        }, // Implement the onTap functionality here
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          primary: Colors.blue,
                          // Background color
                          onPrimary: Colors.white,
                          // Text color
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Confirm Details',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailText(String label, String value,
      [bool isBold = false, Color? color]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color ?? Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchOrderDetails(orderId);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title:
              // TextWidget(title: 'Edit Inventory',textColor: LightAppColor.bgColor,fontSize: 16,),
              Text(
            'Order Detail',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 600,
              width: ResponsiveWidget.isSmallScreen(context)
                  ? 600
                  : ResponsiveWidget.isLargeScreen(context)
                      ? 700
                      : 650,
              child: Obx(() {
                return controller.state.loaded == false
                    ? Center(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.green,
                        )),
                      )
                    : _returnDetails(context);
              }),
            ),
          ),
        ),
      ),
    );
  }
}
