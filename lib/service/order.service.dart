// ignore: depend_on_referenced_packages
import 'package:firebase_database/firebase_database.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:automobile_spare_parts_app/data/models/order.model.dart';

class OrderService {
  // Firebase collection instance to access DB logic
  final orderCollection = FirebaseDatabase.instance.ref().child('orders');

  /// Utilizes firebase database instance and push the prepared order details to the firebase realtime DB using push() method
  Future<void> createOrder(OrderModel orderModel) async {
    await orderCollection
        .push()
        .set({
          'userId': orderModel.userId,
          'orderNumber': orderModel.orderNumber,
          'imgUrl': orderModel.imgUrl,
          'itemId': orderModel.itemId,
          'itemPrice': orderModel.itemPrice,
          'itemName': orderModel.itemName,
          'quantity': orderModel.quantity,
          'totalPrice': orderModel.totalPrice,
          'deliveryAddress': orderModel.deliveryAddress,
        })
        .then((value) => print(Constants.CREATE_SUCCESS))
        .catchError((error) => print(Constants.CREATE_ERROR));
  }

// Utilizes the firebase database instance and update the modified data in the firebase realtime database
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
        .then((value) => print(Constants.UPDATE_SUCCESS))
        .catchError((error) => print(Constants.UPDATE_ERROR));
  }

// Utilizes the firebase database instance and delete the data from the firebase realtime database
  Future<void> deleteOrder(String? orderId) async {
    await orderCollection
        .child(orderId ?? "")
        .remove()
        .then((value) => print(Constants.DELETE_SUCCESS))
        .catchError((error) => print(Constants.DELETE_ERROR));
  }
}
