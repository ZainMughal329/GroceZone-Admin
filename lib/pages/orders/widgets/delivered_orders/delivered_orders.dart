import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/pages/orders/widgets/orders_detail/orders_detail.dart';
import 'package:intl/intl.dart';

import '../../../../components/custom_text.dart';
import '../../../../helpers/responsive.dart';

class DeliveredOrdersView extends StatelessWidget {
  DeliveredOrdersView({Key? key}) : super(key: key);

  Widget _buildListTile(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot, index, String datetime) {
    if (snapshot.hasError) {
      print('Error');
      return Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.black,
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        ),
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      print('Waiting');
      return Center(
        child: Container(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        ),
      );
    }
    return snapshot.hasData
        ? Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0), // Adjust margin as needed
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          leading: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data!.docs[index]['name']
                      .toString()
                      .split('')
                      .take(5)
                      .join('')
                      .length >=
                      5
                      ? snapshot.data!.docs[index]['name']
                      .toString()
                      .split('')
                      .take(5)
                      .join('')
                      .toString() +
                      '...'
                      : snapshot.data!.docs[index]['name'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  datetime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Text(
                    snapshot.data!.docs[index]['number']
                        .toString()
                        .split('')
                        .take(5)
                        .join('')
                        .length >=
                        5
                        ? snapshot.data!.docs[index]['number']
                        .toString()
                        .split('')
                        .take(5)
                        .join('')
                        .toString() +
                        '...'
                        : snapshot.data!.docs[index]['number'].toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    snapshot.data!.docs[index]['paymentMethod']
                        .toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Address: " +
                        (snapshot.data!.docs[index]['address']
                            .toString()
                            .split('')
                            .take(5)
                            .join('')
                            .length >=
                            5
                            ? snapshot.data!.docs[index]['address']
                            .toString()
                            .split('')
                            .take(5)
                            .join('') +
                            '...'
                            : snapshot.data!.docs[index]['address']
                            .toString())
                            .toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'RS ${snapshot.data!.docs[index]['orderPrice']}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          trailing: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => OrderDetailView(orderId: snapshot.data!.docs[index]['orderId'].toString(),),);
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
                CustomText(
                  text: snapshot.data!.docs[index]['status']
                      .toString()
                      .capitalizeFirst
                      .toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        : Container();
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
        Text(
          'Delivered Orders',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance.collection('allOrders').where('status' , isEqualTo: 'delivered').snapshots(),

          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.black,
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              return
                snapshot.data!.docs.length !=0 ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveWidget.isSmallScreen(context)
                        ? 1
                        : ResponsiveWidget.isLargeScreen(context)
                        ? 3
                        : 2,
                    childAspectRatio: ResponsiveWidget.isSmallScreen(context)
                        ? 3.0
                        : ResponsiveWidget.isLargeScreen(context)
                        ? 2.8
                        : 2.5,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final timeInMilliSeconds = int.parse(
                      snapshot.data!.docs[index]['orderId'].toString(),
                    );
                    final dateTime =
                    DateTime.fromMicrosecondsSinceEpoch(timeInMilliSeconds);
                    String formattedDate = DateFormat('dd-MM').format(dateTime);
                    return _buildListTile(
                        context, snapshot, index, formattedDate);
                  },
                ) :
                Center(
                  child: CustomText(
                    text: 'No Orders Yet',
                    size: 60,
                    weight: FontWeight.bold,
                  ),
                );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
