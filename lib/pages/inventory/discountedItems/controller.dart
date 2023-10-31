import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/snackbar_widget.dart';

import 'state.dart';
// import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
// import 'package:grocery_app/pages/AdminScreens/InventoryScreens/DiscountedItems/state.dart';

class DiscountedItemController extends GetxController{
  final state = DiscountedItemState();
  final allItemRef = FirebaseFirestore.instance.collection('Items').where('discount' , isNotEqualTo: 0).snapshots();


  bool val = true;

  setval(bool value){
    val = value;
  }



  Future<void> deleteItem (String id)async{
    await FirebaseFirestore.instance.collection('Items').doc(id).delete().then((value){
      Snackbar.showSnackBar('Delete', "Item deleted Successfully");
    }).onError((error, stackTrace){
      Snackbar.showSnackBar("Error", error.toString());
    });
  }
}