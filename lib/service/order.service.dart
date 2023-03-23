import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderService {
  final orderCollection = FirebaseDatabase.instance.ref().child('orders');

  Future<void> createOrder(OrderModel orderModel) async {
    final json = orderModel.toJson();
    await orderCollection
        .push()
        .set({
          'userId': orderModel.userId,
          'orderNumber': orderModel.orderNumber,
          'imgUrl': orderModel.imgUrl,
          'itemId': orderModel.itemId,
          'itemName': orderModel.itemName,
          'quantity': orderModel.quantity,
          'totalPrice': orderModel.totalPrice,
          'deliveryAddress': orderModel.deliveryAddress,
        })
        .then((value) => print("Order Placed Successfully"))
        .catchError((error) => print("Failed"));
  }

  Future<List<OrderModel>> fetchOrderList() async {
    final snapshot = await FirebaseDatabase.instance.ref('orders').get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    List<OrderModel> ordersList = [];
    map.forEach((key, value) {
      OrderModel order = OrderModel(
          userId: value["userId"],
          orderNumber: value["orderNumber"],
          imgUrl: value["imgUrl"],
          itemId: value["itemId"],
          itemName: value["itemName"],
          quantity: value["quantity"],
          totalPrice: value["totalPrice"],
          deliveryAddress: value["deliveryAddress"]);
      ordersList.add(order);
    });
    return ordersList;
  }

  Future<void> updateOrder(OrderModel order, String? orderId) async {
    final Map<String, dynamic> updateData = {
      'userId': order.userId,
      'orderNumber': order.orderNumber,
      'imgUrl': order.imgUrl,
      'itemId': order.itemId,
      'itemName': order.itemName,
      'quantity': order.quantity,
      'totalPrice': order.totalPrice,
      'deliveryAddress': order.deliveryAddress,
    };

    await orderCollection
        .child(orderId ?? "")
        .update(updateData)
        .then((value) => print("Order Updated Successfully"))
        .catchError((error) => print("Failed"));
  }
}
