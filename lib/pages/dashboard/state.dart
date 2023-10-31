import 'package:get/get.dart';

class DashBoardState {
  Rx<bool> loaded = false.obs;
  RxInt totalSales = 0.obs;
  RxInt totalOrders = 0.obs;
  RxInt pendingOrders= 0.obs;
  RxInt shippedOrders= 0.obs;
  RxInt deliveredOrders= 0.obs;
  RxInt cancelledOrders = 0.obs;
  RxString orderPricesForLastSevenDays = '0'.obs;
  RxString orderPricesForLastDay = '0'.obs;

  RxString orderPricesForLastMonth = '0'.obs;
  RxString orderPricesForLastYear = '0'.obs;

  RxInt orderCounts = 0.obs;




}