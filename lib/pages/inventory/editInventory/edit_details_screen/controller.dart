import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/snackbar_widget.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';


class EditScreenController extends GetxController {
  final dbRef = FirebaseFirestore.instance.collection('Items');
  final state = EditScreenState();
  final picker = ImagePicker();

  XFile? _image;
  XFile? get Image => _image;
  Future pickImageFromGallery() async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      Snackbar.showSnackBar('Image', "Added Successfully");
      update();
    }
  }

  DocumentSnapshot? document;

  void fetchItem(String id) async {
    try {
      DocumentSnapshot document =
      await dbRef.doc(id).get();

      if (document.exists) {
        state.titleController.text = document['title'];
        state.priceController.text = document['price'].toString();
        state.descriptionController.text = document['description'];
        state.stockController.text = document['stock'].toString();
        state.discountController.text = document['discount'].toString();
        state.imageUrl = document['imageUrl'];
        state.priceQtyValue.value = document['priceQty'];
        state.loaded.value = true;
      }
    } catch (e) {
      // handle error
      print(e);
    }
  }

  Future<void> updateData(String id) async {
    setLoading(true);
    try {
      await dbRef.doc(id).update({
        'title': state.titleController.text.trim().toString(),
        'price': int.parse(state.priceController.text.trim().toString()),
        'description': state.descriptionController.text.trim().toString(),
        'stock': int.parse(state.stockController.text.trim().toString()),
        'discount': int.parse(state.discountController.text.trim().toString()),
        'priceQty': state.priceQtyValue.value.toString(),
      }).then((value) {
        if (Image != null) {
          Snackbar.showSnackBar("Updated Successfully", "Uploading Image...");
          uploadImage(id);
        } else {
          Snackbar.showSnackBar("Item", "Updated Successfully");
          setLoading(false);
          // Get.toNamed(AppRoutes.inventoryEditItem);
        }
      }).onError((error, stackTrace) {
        setLoading(false);
        Snackbar.showSnackBar("Error", error.toString());
      });
    } catch (e) {
      setLoading(false);
      Snackbar.showSnackBar("Error", e.toString());
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
        'imageUrl': itemUploadedImage.toString(),
      }).then((value) {
        setLoading(false);
        Snackbar.showSnackBar("Item", 'Updated Successfully');
        // Get.toNamed(AppRoutes.adminInventoryMng);

        // clearControllers();
        // final controller = Get.find<EditItemController>();
        // Get.put(controller);
        // Get.toNamed(AppRoutes.inventoryEditItem);
      }).onError((error, stackTrace) {
        setLoading(false);
        Snackbar.showSnackBar("Error", error.toString());
      });
    } catch (e) {
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    state.loading.value = value;
  }


}
