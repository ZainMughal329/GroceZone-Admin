import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:grocery_app/components/models/user_model.dart';

class ItemModel {

  final String title;
  final int price;
  final String priceQty;
  final int stock;
  final String imageUrl;
  final String category;
  final String subCategory;
  final String description;
  String? itemId;
  int? discount;

  ItemModel({

    required this.title,
    required this.price,
    required this.priceQty,
    required this.stock,
    required this.category,
    required this.subCategory,
    required this.description,
    this.itemId ='',
    this.imageUrl = '' ,
    this.discount = 0,
  });

  toJson(){
    return {
      'itemId' : itemId,
      'title' : title,
      'description' : description,
      'price' : price,
      'priceQty' : priceQty,
      'stock' : stock,
      'category' : category,
      'subCategory' : subCategory,
      'imageUrl' : imageUrl,
      'discount' :discount,
    };
  }


  factory ItemModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final data = snapshot.data()!;
    return ItemModel(
      itemId:  data['itemId'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
      priceQty: data['priceQty'],
      stock: data['stock'],
      imageUrl: data['imageUrl'],
      discount: data['discount'],
      category: data['category'],
      subCategory: data['subCategory'],
    );


  }



}