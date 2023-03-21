import 'package:automobile_spare_parts_app/data/models/order.model.dart';
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
}
