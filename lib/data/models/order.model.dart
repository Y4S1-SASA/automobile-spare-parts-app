import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  final String userId;
  String orderNumber;
  String imgUrl;
  String itemId;
  String itemName;
  String quantity;
  String totalPrice;
  String deliveryAddress;

  OrderModel(
      {this.orderId,
      required this.userId,
      required this.orderNumber,
      required this.imgUrl,
      required this.itemId,
      required this.itemName,
      required this.quantity,
      required this.totalPrice,
      required this.deliveryAddress});

  // factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final data = doc.data()!;
  //   return OrderModel(
  //       userId: data["userId"],
  //       orderNumber: data["orderNumber"],
  //       imgUrl: data["imgUrl"],
  //       itemId: data["itemId"],
  //       itemName: data["itemName"],
  //       quantity: data["quantity"],
  //       totalPrice: data["totalPrice"],
  //       deliveryAddress: data["deliveryAddress"]);
  // }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'orderNumber': orderNumber,
        'imgUrl': imgUrl,
        'itemId': itemId,
        'itemName': itemName,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'deliveryAddress': deliveryAddress,
      };

  // static OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
  //     userId: json["userId"],
  //     orderNumber: json["orderNumber"],
  //     imgUrl: json["imgUrl"],
  //     itemId: json["itemId"],
  //     itemName: json["itemName"],
  //     quantity: json["quantity"],
  //     totalPrice: json["totalPrice"],
  //     deliveryAddress: json["deliveryAddress"]);
}
