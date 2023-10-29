import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/custom_text.dart';
import 'package:groce_zone_admin/pages/orders/widgets/order_items/controller.dart';

import '../../../../helpers/responsive.dart';

class OrderItemsView extends GetView<OrderItemsController> {
  String orderId;
  String customerId;
  OrderItemsView({Key? key,required this.orderId,required this.customerId}) : super(key: key);
  final controller = Get.put<OrderItemsController>(OrderItemsController());

  Widget _buildListTile(
      BuildContext context,
      String img,
      String title,
      String category,
      String subCategory,
      int price,
      int discount,
      String orderId,
      String status,
      int itemQty,
      ) {
    Color statusColor;

    // Customize the color based on the order status
    switch (status) {
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Shipped':
        statusColor = Colors.orange;
        break;
      case 'Pending':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.black;
        break;
    }
    void _showOrderDetailsDialogue(BuildContext context) {
      final orderDetailsContent = Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            // Add order details such as image, name, etc. here
            // Example:
            Center(
              child: Container(
                height: 100,
                width: 100,
                child: Image.network(img),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            CustomText(
              text: 'Order #' + orderId,
              size: 15,
              weight: FontWeight.bold,
            ),

            SizedBox(
              height: 5,
            ),
            CustomText(
                text: 'Item Name: ' + title),
            SizedBox(
              height: 5,
            ),

            CustomText(
                text: 'ItemQuantity: ' + itemQty.toString()),
            SizedBox(
              height: 5,
            ),

            CustomText(
                text: 'Category: ' + category),
            SizedBox(
              height: 5,
            ),
            CustomText(
                text: 'Sub-Category: ' + subCategory),
            SizedBox(
              height: 5,
            ),
            CustomText(
              text: 'Original Price ' + (price * itemQty).toString(),
            ),
            SizedBox(
              height: 5,
            ),

            CustomText(
              text: 'Discount: ' + discount.toString() + '%',
            ),
          ],
        ),
      );

      Get.defaultDialog(
        title: 'Order Details',
        content: orderDetailsContent,
        radius: 10.0,
        // cancelTextColor: Colors.orange,
        cancel: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Colors.orange,
                        ),),),
                child: Center(
                    child:
                    CustomText(
                        text: 'Close', color: Colors.orange),),),),
      );
    }

    return GestureDetector(
      onTap: () {
        _showOrderDetailsDialogue(context);
      },
      child: Card(
        margin: EdgeInsets.only(right: 16, left: 16, top: 12),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Order #' + orderId,
                size: 17,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 8.0),
              CustomText(
                text: 'Title: $title',
                size: 12,
              ),
              SizedBox(height: 8.0),
              CustomText(
                text: 'Quantity: '+ itemQty.toString(),
                size: 12,
              ),
              SizedBox(height: 8.0),
              CustomText(
                text: 'Price: '+ ((price - ((discount/price)*100)) * itemQty).toString(),
                size: 12,
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 8.0),
              CustomText(
                text: 'Status: $status',
                color: statusColor,
                weight: FontWeight.bold,
                size: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back , color: Colors.white,),
        ),

        title:
        // TextWidget(title: 'Edit Inventory',textColor: LightAppColor.bgColor,fontSize: 16,),
        Text(
          'Order Items',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),

      ),
      body: FutureBuilder(
        future: controller.getAllOrdersData(customerId,orderId),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.green,),);
          }
          if (snapshot.hasData) {
            return snapshot.data!.length != 0
                ?  GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveWidget.isSmallScreen(context)
                    ? 1
                    : ResponsiveWidget.isLargeScreen(context)
                    ? 3
                    : 2,
                childAspectRatio: ResponsiveWidget.isSmallScreen(context)
                    ? 2.7
                    : ResponsiveWidget.isLargeScreen(context)
                    ? 2.0
                    : 2.4,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: _buildListTile(
                    context,
                    snapshot.data![index].itemImg,
                    snapshot.data![index].itemName,
                    snapshot.data![index].category,
                    snapshot.data![index].subCategory,
                    snapshot.data![index].totalPrice.toInt(),
                    snapshot.data![index].discount.toInt(),
                    snapshot.data![index].orderId,
                    snapshot.data![index].status.toString(),
                    snapshot.data![index].itemQty,
                  ),
                );
              },
            )
                : Column(
              children: [
                CustomText(
                  text: 'No items here yet.',
                  size: 60,
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            print('Error : ' + snapshot.error.toString());
            return Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          } else {
            return Container();
          }
        },

      ),
    );
  }
}
