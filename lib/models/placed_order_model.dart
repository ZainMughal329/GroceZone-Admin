import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceOrderModel {
  final String orderId;
  final String customerId;
  final String name;
  final String number;
  final String address;
  final String addressLabel;
  final String paymentMethod;
  final int orderPrice;
  final String ?status;

  PlaceOrderModel({
    required this.orderId,
    required this.customerId,
    required this.name,
    required this.number,
    required this.address,
    required this.addressLabel,
    required this.paymentMethod,
    required this.orderPrice,
    this.status,
  });

  toJson() {
    return {
      'orderId' : orderId,
      'customerId' : customerId,
      'name' : name ,
      'number' : number ,
      'address' : address ,
      'addressLabel' : addressLabel ,
      'paymentMethod' : paymentMethod,
      'orderPrice' : orderPrice,
      'status':'pending',
    };
  }

  factory PlaceOrderModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final data = snapshot.data()!;
    return PlaceOrderModel(
        orderId: data['orderId'],
        customerId: data['customerId'],
        name: data['name'],
        number: data['number'],
        address: data['address'],
        addressLabel: data['addressLabel'],
        paymentMethod: data['paymentMethod'],
        orderPrice: data['orderPrice'],
        status: data['pending']
    );


  }


}