// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/screens/order-list.dart';
import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:automobile_spare_parts_app/service/order.service.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../../../utils.dart';
import '../shared/components/incrementor.dart';
import '../shared/components/input-text.dart';
import '../shared/components/label-name.dart';
import '../shared/components/label-value.dart';

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
  late OrderModel currentOrder;
  final OrderService _orderService = OrderService();
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
        itemPrice: widget.orderModel.itemPrice,
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
  String itemPrice = '';
  var quantity = '';
  var totalPrice = '';
  var deliveryAddress = '';

  // void _appBarIconTap(int index) {
  //   setState(() {
  //     _selectedAppBarIconIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70 * fem,
              width: double.infinity,
              color: Color.fromARGB(255, 6, 84, 79),
            ),
            Container(
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
                        Constants.LEFT_ARROW_ICON,
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
                    Constants.EDIT_ORDERS_TITLE,
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
                    child: Image.network(currentOrder.imgUrl),
                    // contentblockQ9E (I9:522;150:1080)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                    width: double.infinity,
                    height: 240 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * fem),
                      color: Color(0xfff6f6f6),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8 * fem),
                  //     color: const Color.fromARGB(255, 187, 186, 186),
                  //   ),
                  // ),
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
                                var totPrice =
                                    int.parse(currentOrder.itemPrice) *
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
                        color: const Color.fromARGB(255, 6, 84, 79),
                        borderRadius: BorderRadius.circular(8 * fem),
                      ),
                      child: IconButton(
                        icon: Image.asset(Constants.LOCATION_ICON),
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
                  color: const Color.fromARGB(255, 6, 84, 79),
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
                        itemPrice: currentOrder.itemPrice,
                        itemName: currentOrder.itemName,
                        quantity: currentOrder.quantity,
                        totalPrice: currentOrder.totalPrice,
                        deliveryAddress: currentOrder.deliveryAddress);
                    var result = _orderService.updateOrder(
                        orderObj, currentOrder.orderId);
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(Constants.UPDATE_ERROR)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(Constants.UPDATE_SUCCESS)),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderList()),
                      );
                    }
                  },
                  color: const Color.fromARGB(255, 6, 84, 79),
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
    );
  }
}
}
