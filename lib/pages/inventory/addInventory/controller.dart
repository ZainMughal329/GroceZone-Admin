import 'dart:io';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/snackbar_widget.dart';
import 'package:groce_zone_admin/models/item_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'state.dart';

class AddItemController extends GetxController {
  final state = AddItemState();
  final picker = ImagePicker();
  final dbRef = FirebaseFirestore.instance.collection('Items');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void setLoading(bool value) {
    state.loading.value = value;
  }

  // final pickedImage ='';

  XFile? _image;
  XFile? get Image => _image;
  String? imageUrl = '';
  // Future pickImageFromGallery() async {
  //   final pickedImage =
  //   await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
  //
  //   if (pickedImage != null) {
  //     _image = XFile(pickedImage.path);
  //     Snackbar.showSnackBar('Image', "Added Successfully");
  //     update();
  //   }
  // }

  Future<XFile?> pickImageFromGallery() async {
    // Image? fromPicker = await ImagePickerWeb.getImageAsWidget();
    final pickedImage = await ImagePickerWeb.getImageAsFile();
    // final pickedImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
    if (pickedImage != null) {
      onFilePicked(pickedImage);

      // print("imagePicked"+pickedImage.asStream().toString());
      // return XFile(pickedImage.toString());

    }
    return null;
  }

  void onFilePicked(html.File file) {
    final reader = html.FileReader();
    reader.readAsDataUrl(file);
    print(reader.toString());
    reader.onLoadEnd.listen((event) {
      imageUrl = reader.result as String?;
      // print(imageUrl);
    });
  }

  // select subCategoryList
  List<DropdownMenuItem> subCatList(String value) {
    if (value == 'Kitchen') {
      return state.KitchenSubCatList;
    } else if (value == 'Bathroom') {
      return state.BathroomSubCatList;
    } else if (value == 'Grocery') {
      return state.GrocerySubCatList;
    } else if (value == 'HouseHold') {
      return state.HouseHoldSubCatList;
    } else if (value == 'Clothing') {
      return state.ClothingSubCatList;
    } else
      return [];
  }

  //AddItem in DataBase

  Future<void> addItem(ItemModel item) async {
    setLoading(true);
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      await dbRef.doc(id).set(item.toJson()).then((value) {
        Snackbar.showSnackBar("Item Added in DataBase", "Uploading Image");
        uploadImage(id);
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("Error", error.toString());
        setLoading(false);
      });
    } catch (e) {
      Snackbar.showSnackBar('Error', e.toString());
      setLoading(false);
    }
  }

  Future uploadImage(String id) async {
    // setLoading(true);
    try {
      firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref('/itemImage' + id);
      firebase_storage.UploadTask uploadTask =
      storageRef.putFile(File(Image!.path).absolute);

      await Future.value(uploadTask);

      final itemUploadedImage = await storageRef.getDownloadURL();

      dbRef.doc(id).update({
        'itemId': id,
        'imageUrl': itemUploadedImage.toString(),
      }).then((value) {
        setLoading(false);
        Snackbar.showSnackBar("Item", 'Added Successfully');
        // Get.toNamed(AppRoutes.adminInventoryMng);
        clearControllers();
      }).onError((error, stackTrace) {
        setLoading(false);
        Snackbar.showSnackBar("Error", error.toString());
      });
    } catch (e) {
      setLoading(false);
    }
  }

  void clearControllers() {
    state.titleController.clear();
    state.descriptionController.clear();
    state.stockController.clear();
    state.priceController.clear();
    state.discountController.clear();
    state.priceQtyValue.value = 'Select';
    state.categoryValue.value = 'Select';
    state.subCategoryValue.value = 'Select';
    _image = null;
    update();
  }
}
