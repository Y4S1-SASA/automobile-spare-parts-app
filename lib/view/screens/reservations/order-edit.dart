import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:automobile_spare_parts_app/service/order.service.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-create.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/order-list.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/payment-gateway.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/incrementor.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/input-text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils.dart';
import 'shared/label-name.dart';
import 'shared/label-value.dart';

class EditOrder extends StatefulWidget {
  const EditOrder({
    super.key,
    required this.orderModel,
  });
  final OrderModel orderModel;

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  int _selectedAppBarIconIndex = 1;
  late OrderModel currentOrder;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController addressController;
  late TextEditingController itemNameController;
  late TextEditingController orderNumberController;

  @override
  void initState() {
    super.initState();
    currentOrder = OrderModel(
        orderId: widget.orderModel.orderId,
        userId: widget.orderModel.userId,
        orderNumber: widget.orderModel.orderNumber,
        imgUrl: widget.orderModel.imgUrl,
        itemId: widget.orderModel.itemId,
        itemName: widget.orderModel.itemName,
        quantity: widget.orderModel.quantity,
        totalPrice: widget.orderModel.totalPrice,
        deliveryAddress: widget.orderModel.deliveryAddress);
    // quantityController =
    //     TextEditingController(text: widget.orderModel.quantity);
    // priceController = TextEditingController(text: widget.orderModel.totalPrice);
    addressController =
        TextEditingController(text: widget.orderModel.deliveryAddress);
    itemNameController = TextEditingController(text: currentOrder.itemName);
    orderNumberController =
        TextEditingController(text: currentOrder.orderNumber);
  }

  String orderNumber = '';
  String imgUrl =
      'https://firebasestorage.googleapis.com/v0/b/automobile-spare-parts-app.appspot.com/o/images%2F1679407761082?alt=media&token=243f3f65-4201-4b90-951f-5f38d2efc427';
  String itemId = 'I001';
  String itemName = 'Spark Plug';
  String itemPrice = '300';
  var quantity = '';
  var totalPrice = '';
  var deliveryAddress = '';

  void _appBarIconTap(int index) {
    setState(() {
      _selectedAppBarIconIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final OrderService _orderService = OrderService();
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.green, title: Text('')), // App Bar
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70 * fem,
              width: double.infinity,
              color: Colors.green,
            ),
            Container(
              // Heading place order and back arrow
              margin:
                  EdgeInsets.fromLTRB(33 * fem, 0 * fem, 155 * fem, 0 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 110.35 * fem, 0 * fem),
                    width: 11.65 * fem,
                    height: 66 * fem,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/page-1/images/icon-arrow-left-1-3tC.png',
                        width: 11.65 * fem,
                        height: 26 * fem,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ),
                  Text(
                    'Place Order',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 24 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.2125 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // Image of the item
              margin:
                  EdgeInsets.fromLTRB(149 * fem, 0 * fem, 157 * fem, 35 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8 * fem),
              ),
              child: Center(
                // contentblockdyA (1:79)
                child: SizedBox(
                  width: double.infinity,
                  height: 139 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * fem),
                      color: const Color.fromARGB(255, 187, 186, 186),
                    ),
                  ),
                ),
              ),
            ),
            InputText(
                onChanged: (value) {
                  orderNumber = orderNumber;
                },
                labelName: 'Order Number',
                hint: orderNumber,
                enabled: false,
                controller: orderNumberController),
            InputText(
                onChanged: (value) {
                  itemName = itemName;
                },
                labelName: 'Item Name',
                hint: itemName,
                enabled: false,
                controller: itemNameController),
            Container(
              margin:
                  EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32.41 * fem, 0 * fem),
              width: double.infinity,
              height: 105 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelName(labelName: 'Quantity'),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffe7e7e7)),
                            color: const Color(0xfff6f6f6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Incrementor(
                              minValue: 0,
                              maxValue: 10,
                              onChanged: (value) {
                                currentOrder.quantity = value.toString();
                                var totPrice = int.parse(itemPrice) *
                                    int.parse(currentOrder.quantity);
                                totalPrice = totPrice.toString();
                                setState(() {
                                  currentOrder.totalPrice = totalPrice;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        32 * fem, 0 * fem, 0 * fem, 22 * fem),
                    width: 190 * fem,
                    // height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelName(labelName: 'TotalPrice'),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffe7e7e7)),
                            color: const Color(0xfff6f6f6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: LabelValue(
                              labelValue: currentOrder.totalPrice,
                              disabled: false),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 105 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 340 * fem,
                    height: double.infinity,
                    child: InputText(
                        onChanged: (value) {
                          currentOrder.deliveryAddress = value;
                        },
                        labelName: 'Delivery Address',
                        hint: 'Delivery Address',
                        enabled: true,
                        controller: addressController),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        10 * fem, 0 * fem, 0 * fem, 10 * fem),
                    width: 50 * fem,
                    height: 50 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff5db075),
                        borderRadius: BorderRadius.circular(8 * fem),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                            'assets/page-1/images/icon-location.png'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(88 * fem, 0 * fem, 87 * fem, 58 * fem),
              width: double.infinity,
              height: 45 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30 * fem),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff5db075),
                  borderRadius: BorderRadius.circular(30 * fem),
                ),
                child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  elevation: 2.0,
                  height: 45,
                  minWidth: 270,
                  onPressed: () {
                    var orderObj = OrderModel(
                        userId: currentOrder.userId,
                        orderNumber: currentOrder.orderNumber,
                        imgUrl: currentOrder.imgUrl,
                        itemId: currentOrder.itemId,
                        itemName: currentOrder.itemName,
                        quantity: currentOrder.quantity,
                        totalPrice: currentOrder.totalPrice,
                        deliveryAddress: currentOrder.deliveryAddress);
                    // var result = _orderService.updateOrder(orderObj, currentOrder.orderId)

                    // var totPrice = int.parse(itemPrice) * int.parse(quantity);
                    // totalPrice = totPrice.toString();
                    // final orderObj = OrderModel(
                    //     userId: userId,
                    //     orderNumber: orderNumber,
                    //     imgUrl: imgUrl,
                    //     itemId: itemId,
                    //     itemName: itemName,
                    //     quantity: quantity,
                    //     totalPrice: totalPrice,
                    //     deliveryAddress: deliveryAddress);
                    var result = _orderService.updateOrder(
                        orderObj, currentOrder.orderId);
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ERROR!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Order updated successfully!')),
                      );
                    }
                    //   quantityController.clear();
                    //   priceController.clear();
                    //   addressController.clear();
                    // }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => OrderList()),
                    // );
                  },
                  color: const Color(0xff5db075),
                  child: const Text(
                    "Save Edited Order",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      // Don't write bottom app bar here. - SHEHAN
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   color: const Color(0xff5db075),
      //   height: 60,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 0
      //             ? Image.asset('assets/appbar/article_filled.png')
      //             : Image.asset('assets/appbar/article.png'),
      //         onPressed: () {
      //           _appBarIconTap(0);
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => Scene()),
      //           );
      //         },
      //       ),
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 1
      //             ? Image.asset('assets/appbar/market_filled.png')
      //             : Image.asset('assets/appbar/market.png'),
      //         onPressed: () => _appBarIconTap(1),
      //       ),
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 2
      //             ? Image.asset('assets/appbar/reservation_filled.png')
      //             : Image.asset('assets/appbar/reservation.png'),
      //         onPressed: () {
      //           _appBarIconTap(0);
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const OrderList()),
      //           );
      //         },
      //       ),
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 3
      //             ? Image.asset('assets/appbar/profile_filled.png')
      //             : Image.asset('assets/appbar/profile.png'),
      //         onPressed: () => _appBarIconTap(3),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
