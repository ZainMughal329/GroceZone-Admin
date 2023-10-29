import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final String orderId;
  final String customerId;
  final String customerName;
  final int totalPrice;
  final String itemId;
  final String itemName;
  final DateTime? dateTime;
  final int itemQty;
  final String itemImg;
  final String category;
  final String subCategory;
  final int discount;
  final String ?status;
  final String ?isPaymentDone;


  OrderModel({
    this.id,
    required this.orderId,
    required this.customerId,
    required this.customerName,
    required this.totalPrice,
    required this.itemId,
    this.dateTime,
    required this.itemName,
    required this.itemQty,
    required this.itemImg,
    required this.category,
    required this.subCategory,
    required this.discount,
    this.status,
    this.isPaymentDone,
  });

  toJson(){
    return {
      'id' : id,
      'orderId' : orderId,
      'customerId' : customerId,
      'customerName' : customerName,
      'totalPrice' : totalPrice,
      'itemId' :itemId,
      'dateTime' : dateTime,
      'items' : itemName,
      'itemQty' : itemQty,
      'itemImg' : itemImg,
      'category' : category,
      'subCategory' : subCategory,
      'discount' : discount,
      'status' : 'pending',
      'isPaymentDone' : 'no',
    };
  }

  factory OrderModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final data = snapshot.data()!;
    return OrderModel(
      id: data['id'],
      orderId:  data['orderId'],
      customerId: data['customerId'],
      customerName: data['customerName'],
      totalPrice: data['totalPrice'],
      itemId : data['itemId'],
      dateTime: data['dateTime'],
      itemName: data['items'],
      itemQty: data['itemQty'],
      itemImg : data['itemImg'],
      category: data['category'],
      subCategory: data['subCategory'],
      discount: data['discount'],
      status: data['status'],
      isPaymentDone: data['isPaymentDone'],
    );


  }

}