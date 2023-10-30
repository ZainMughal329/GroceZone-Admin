import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/text_widget.dart';
// import 'package:grocery_app/components/reuseable/text_widget.dart';
// import 'package:image_picker/image_picker.dart';

class AddItemState {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockController = TextEditingController();
  final discountController = TextEditingController();

  RxString priceQtyValue = 'Select'.obs;
  Rx<bool> loading = false.obs;



  RxString categoryValue = 'Select'.obs;

  RxString subCategoryValue = 'Select'.obs;


  final KitchenSubCatList = <DropdownMenuItem>[
    DropdownMenuItem(
      child: TextWidget(
        title: 'Appliances',
        fontSize: 14,
      ),
      value: 'Appliances',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Cookwares',
        fontSize: 14,
      ),
      value: 'Cookwares',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Gadgets',
        fontSize: 14,
      ),
      value: 'Gadgets',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Storage',
        fontSize: 14,
      ),
      value: 'Storage',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Cleaning',
        fontSize: 14,
      ),
      value: 'Cleaning',
    ),
  ];

  final BathroomSubCatList = <DropdownMenuItem>[
    DropdownMenuItem(
      child: TextWidget(
        title: 'Hygiene',
        fontSize: 14,
      ),
      value: 'Hygiene',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Soaps',
        fontSize: 14,
      ),
      value: 'Soaps',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Shampoos',
        fontSize: 14,
      ),
      value: 'Shampoos',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Conditioners',
        fontSize: 14,
      ),
      value: 'Conditioners',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Cleaners',
        fontSize: 14,
      ),
      value: 'Cleaners',
    ),
  ];

  final GrocerySubCatList = <DropdownMenuItem>[
    DropdownMenuItem(
      child: TextWidget(
        title: 'Vegetables',
        fontSize: 14,
      ),
      value: 'Vegetables',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Fruits',
        fontSize: 14,
      ),
      value: 'Fruits',
    ),

    DropdownMenuItem(
      child: TextWidget(
        title: 'Meat',
        fontSize: 14,
      ),
      value: 'Meat',
    ),

    DropdownMenuItem(
      child: TextWidget(
        title: 'Bakery',
        fontSize: 14,
      ),
      value: 'Bakery',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Beverages',
        fontSize: 14,
      ),
      value: 'Beverages',
    ),
  ];

  final HouseHoldSubCatList = <DropdownMenuItem>[
    DropdownMenuItem(
      child: TextWidget(
        title: 'Cleaning',
        fontSize: 14,
      ),
      value: 'Cleaning',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Furniture',
        fontSize: 14,
      ),
      value: 'Furniture',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Decor',
        fontSize: 14,
      ),
      value: 'Decor',
    ),

    DropdownMenuItem(
      child: TextWidget(
        title: 'Laundry',
        fontSize: 14,
      ),
      value: 'Laundry',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Dishwashing',
        fontSize: 14,
      ),
      value: 'Dishwashing',
    ),

  ];

  final ClothingSubCatList = <DropdownMenuItem>[
    DropdownMenuItem(
      child: TextWidget(
        title: 'Men',
        fontSize: 14,
      ),
      value: 'Men',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Women',
        fontSize: 14,
      ),
      value: 'Women',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Kids',
        fontSize: 14,
      ),
      value: 'Kids',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Undergarments',
        fontSize: 14,
      ),
      value: 'Undergarments',
    ),
    DropdownMenuItem(
      child: TextWidget(
        title: 'Specialty',
        fontSize: 14,
      ),
      value: 'Specialty',
    ),

  ];


}
