class OrderModel {
  String? orderId;
  final String userId;
  String orderNumber;
  String imgUrl;
  String itemId;
  String itemPrice;
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
      required this.itemPrice,
      required this.itemName,
      required this.quantity,
      required this.totalPrice,
      required this.deliveryAddress});
}
