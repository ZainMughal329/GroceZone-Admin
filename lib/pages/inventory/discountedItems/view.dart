import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/snackbar_widget.dart';
import 'package:groce_zone_admin/components/text_widget.dart';
import 'package:groce_zone_admin/pages/inventory/discountedItems/controller.dart';
import 'package:groce_zone_admin/pages/inventory/editInventory/edit_details_screen/view.dart';


class DiscountedItemView extends GetView<DiscountedItemController> {
  DiscountedItemView({Key? key}) : super(key: key);

  final controller =
  Get.put<DiscountedItemController>(DiscountedItemController());

  Widget _buildlistTile(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot, index, String value) {
    return controller.state.dropDownValue.value == 'All'
        ? Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
                        width: 1.0, color: Colors.grey[200]!))),
            child: Image.network(
              snapshot.data!.docs[index]['imageUrl'],
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ), // assuming you store image URLs in firestore
          ),
          title: Text(
            snapshot.data!.docs[index]['title'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              Text(
                snapshot.data!.docs[index]['category'],
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Text(
                snapshot.data!.docs[index]['subCategory'],
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Text(
                "stock:" + snapshot.data!.docs[index]['stock'].toString(),
                style: TextStyle(fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    'RS${snapshot.data!.docs[index]['price']}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  if (snapshot.data!.docs[index]['discount'] != null &&
                      snapshot.data!.docs[index]['discount'] > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${snapshot.data!.docs[index]['discount']}% OFF',
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Simple Dialog'),
                          content: Text('Delete Item.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                controller.deleteItem(snapshot
                                    .data!.docs[index]['itemId']
                                    .toString());
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                onTap: () {
                  Get.to(() => EditScreenView(
                      id: snapshot.data!.docs[index]['itemId']));
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    )
        : snapshot.data!.docs[index]['category'].toString() == value
        ? Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
                        width: 1.0, color: Colors.grey[200]!))),
            child: Image.network(
              snapshot.data!.docs[index]['imageUrl'],
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ), // assuming you store image URLs in firestore
          ),
          title: Text(
            snapshot.data!.docs[index]['title'],
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              Text(
                snapshot.data!.docs[index]['category'],
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Text(
                snapshot.data!.docs[index]['subCategory'],
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Text(
                "stock:" +
                    snapshot.data!.docs[index]['stock'].toString(),
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    'RS${snapshot.data!.docs[index]['price']}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  if (snapshot.data!.docs[index]['discount'] !=
                      null &&
                      snapshot.data!.docs[index]['discount'] > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${snapshot.data!.docs[index]['discount']}% OFF',
                        style: TextStyle(
                            fontSize: 12, color: Colors.red),
                      ),
                    ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  // Get.toNamed(AppRoutes.inventoryEdit);
                  Get.to(() => EditScreenView(
                      id: snapshot.data!.docs[index]['itemId']));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Simple Dialog'),
                          content: Text('Delete Item.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                controller.deleteItem(snapshot
                                    .data!.docs[index]['itemId']
                                    .toString());
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(DiscountedItemController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: TextWidget(
          title: 'Discount Inventory',
          textColor: Colors.white,
          fontSize: 16,
        ),
        // Text( 'Edit Inventory'
        //   ,style: TextStyle(color: Colors.white,fontSize: 20.sp),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              60.0), // set the height of the custom app bar bottom
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Container(
              color: Colors.orange.withOpacity(0.5),
              height:
              50.0, // you provided this as 50.h (probably using screen_util or another package for responsive design)
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    title: "Apply Filter",
                    textColor: Colors.white,
                    fontSize: 16,
                  ), // This was TextWidget(title: "Apply Filter") in your code
                  Obx(() {
                    return DropdownButton(
                        iconEnabledColor: Colors.white,
                        hint: TextWidget(
                          title:
                          controller.state.dropDownValue.value.toString(),
                          textColor: Colors.white,
                          fontSize: 16,
                        ),
                        items: [
                          DropdownMenuItem(
                            child: TextWidget(
                              title: 'All',
                            ),
                            value: 'All',
                          ),
                          DropdownMenuItem(
                            child: TextWidget(
                              title: 'HouseHold',
                            ),
                            value: 'HouseHold',
                          ),
                          DropdownMenuItem(
                            child: TextWidget(
                              title: 'Grocery',
                            ),
                            value: 'Grocery',
                          ),
                          DropdownMenuItem(
                            child: TextWidget(
                              title: 'Kitchen',
                            ),
                            value: 'Kitchen',
                          ),
                          DropdownMenuItem(
                            child: TextWidget(
                              title: 'Bathroom',
                            ),
                            value: 'Bathroom',
                          ),
                          DropdownMenuItem(
                            child: TextWidget(
                              title: 'Clothing',
                            ),
                            value: 'Clothing',
                          ),
                        ],
                        onChanged: (value) {
                          controller.state.dropDownValue.value = value!;
                        });
                  }),
                ],
              ),
            ), // Updated the padding based on your provided values
            //
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.allItemRef,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            if (snapshot.hasError) {
              Snackbar.showSnackBar('Error', snapshot.error.toString());
              return Container(
                child: Text("Snapshot error"),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No Items in the Database'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Obx(() => _buildlistTile(context, snapshot, index,
                    controller.state.dropDownValue.value.toString()));
              },
            );
          },
        ),
      ),
    );
  }
}
