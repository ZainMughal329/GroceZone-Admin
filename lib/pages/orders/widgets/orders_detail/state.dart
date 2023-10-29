import 'package:get/get.dart';

class OrderDetailsState {


  Rx<bool> loaded = false.obs;
  Rx<String> hint = 'Select'.obs;
  String customerId = '';

}