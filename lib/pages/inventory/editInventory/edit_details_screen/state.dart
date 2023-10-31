import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditScreenState {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockController = TextEditingController();
  final discountController = TextEditingController();
  String imageUrl = '';


  RxString priceQtyValue = 'Select'.obs;
  Rx<bool> loaded = false.obs;
  Rx<bool> loading = false.obs;


}