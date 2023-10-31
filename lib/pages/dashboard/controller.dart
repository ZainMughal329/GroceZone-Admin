import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/pages/dashboard/state.dart';
import 'package:intl/intl.dart';

class DashBoardController extends GetxController {
  var state = DashBoardState();

  void fetchData() {
    fetchAllOrdersData();
    fetchCancelledOrders();
    fetchDeliveredOrders();
    fetchPendingOrders();
    fetchShippedOrders();
    fetchDataAndCalculatePricesForSevenDays();
    fetchDataAndCalculatePricesForLastYear();
    fetchDataAndCalculatePricesForThirtyDays();
    fetchDataAndCalculatePricesForLastDay();
    fetchDataAndCountOrders();
  }

  Future<void> fetchAllOrdersData() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('allOrders').get();
    int totalOrderAmount = 0;
    if (snapshot.docs.isNotEmpty) {
      state.totalOrders.value = snapshot.docs.length;
      // loadedMap.addAll({"Orders": state.totalOrders.toDouble()});
      for (DocumentSnapshot doc in snapshot.docs) {
        int orderPrice = doc['orderPrice'];
        totalOrderAmount = totalOrderAmount + orderPrice;
      }
      state.totalSales.value = totalOrderAmount;
    }
  }

  Future<void> fetchPendingOrders() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('allOrders')
        .where('status', isEqualTo: 'pending')
        .get();

    if (snapshot.docs.isNotEmpty) {
      state.pendingOrders.value = snapshot.docs.length;
    }
  }

  Future<void> fetchShippedOrders() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('allOrders')
        .where('status', isEqualTo: 'shipped')
        .get();

    if (snapshot.docs.isNotEmpty) {
      state.shippedOrders.value = snapshot.docs.length;
    }
  }

  Future<void> fetchDeliveredOrders() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('allOrders')
        .where('status', isEqualTo: 'delivered')
        .get();

    if (snapshot.docs.isNotEmpty) {
      state.deliveredOrders.value = snapshot.docs.length;
    }
  }

  Future<void> fetchCancelledOrders() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('allOrders')
        .where('status', isEqualTo: 'cancelled')
        .get();

    if (snapshot.docs.isNotEmpty) {
      state.cancelledOrders.value = snapshot.docs.length;
    }
  }

  void fetchDataAndCalculatePricesForSevenDays() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference allOrdersCollection = firestore.collection('allOrders');

    try {

      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(
        Duration(days: 7),
      );
      QuerySnapshot querySnapshot = await allOrdersCollection
          .where(
            'orderId',
            isGreaterThanOrEqualTo:
                sevenDaysAgo.microsecondsSinceEpoch.toString(),
          )
          .get();
      double prices = 0.0;

      if (querySnapshot.docs.isNotEmpty) {


        querySnapshot.docs.forEach((doc) {
          // print('loop runs');
          // print('id is : ' + doc['orderId'].toString(),);
          double orderPrice = doc[
              'orderPrice']; // Replace 'orderPrice' with the actual field name in your Firestore document

          prices += orderPrice;
        });

        String formattedTotalPrice =
            '₨ ${NumberFormat.currency(symbol: '', decimalDigits: 2).format(prices)}';

        state.orderPricesForLastSevenDays.value = formattedTotalPrice;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchDataAndCalculatePricesForLastDay() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference allOrdersCollection = firestore.collection('allOrders');

    try {

      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime tomorrow = now.add(
        Duration(days: 1),
      );
      QuerySnapshot querySnapshot = await allOrdersCollection
          .where(
            'orderId',
            isGreaterThanOrEqualTo: today.microsecondsSinceEpoch.toString(),
            isLessThan: tomorrow.microsecondsSinceEpoch.toString(),
          )
          .get();
      double prices = 0.0;

      if (querySnapshot.docs.isNotEmpty) {


        querySnapshot.docs.forEach((doc) {
          double orderPrice = doc[
              'orderPrice']; // Replace 'orderPrice' with the actual field name in your Firestore document

          prices += orderPrice;
        });

        String formattedTotalPrice =
            '₨ ${NumberFormat.currency(symbol: '', decimalDigits: 2).format(prices)}';

        state.orderPricesForLastDay.value = formattedTotalPrice;
      } else {

        state.orderPricesForLastDay.value = '0';
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchDataAndCalculatePricesForThirtyDays() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference allOrdersCollection = firestore.collection('allOrders');

    try {

      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(
        Duration(days: 30),
      );
      QuerySnapshot querySnapshot = await allOrdersCollection
          .where(
            'orderId',
            isGreaterThanOrEqualTo:
                sevenDaysAgo.microsecondsSinceEpoch.toString(),
          )
          .get();
      double prices = 0.0;

      if (querySnapshot.docs.isNotEmpty) {


        querySnapshot.docs.forEach((doc) {
          // print('loop runs');
          // print('id is : ' + doc['orderId'].toString(),);
          double orderPrice = doc[
              'orderPrice']; // Replace 'orderPrice' with the actual field name in your Firestore document

          prices += orderPrice;
        });

        String formattedTotalPrice =
            '₨ ${NumberFormat.currency(symbol: '', decimalDigits: 2).format(prices)}';

        state.orderPricesForLastMonth.value = formattedTotalPrice;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchDataAndCalculatePricesForLastYear() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference allOrdersCollection = firestore.collection('allOrders');

    try {

      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(
        Duration(days: 365),
      );
      QuerySnapshot querySnapshot = await allOrdersCollection
          .where(
            'orderId',
            isGreaterThanOrEqualTo:
                sevenDaysAgo.microsecondsSinceEpoch.toString(),
          )
          .get();
      double prices = 0.0;

      if (querySnapshot.docs.isNotEmpty) {

        // print(
        //   'length is : ' + querySnapshot.docs.length.toString(),
        // );

        querySnapshot.docs.forEach((doc) {
          // print('loop runs');
          // print('id is : ' + doc['orderId'].toString(),);
          double orderPrice = doc[
              'orderPrice']; // Replace 'orderPrice' with the actual field name in your Firestore document

          prices += orderPrice;
        });

        String formattedTotalPrice =
            '₨ ${NumberFormat.currency(symbol: '', decimalDigits: 2).format(prices)}';

        state.orderPricesForLastYear.value = formattedTotalPrice;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchDataAndCountOrders() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference allOrdersCollection = firestore.collection('allOrders');

    try {
      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(Duration(days: 7));
      QuerySnapshot querySnapshot = await allOrdersCollection
          .where('orderId',
          isGreaterThanOrEqualTo:
          sevenDaysAgo.microsecondsSinceEpoch.toString())
          .get();
      if(querySnapshot.docs.isNotEmpty) {
        // print('length : ' +querySnapshot.docs.length.toString(),);

        // print('in query');
        state.orderCounts.value = querySnapshot.docs.length;
        // print('length : ' +querySnapshot.docs.length.toString(),);
      }else{
        state.orderCounts.value = 0;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
