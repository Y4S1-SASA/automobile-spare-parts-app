// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'dart:math';

import 'package:automobile_spare_parts_app/view/screens/reservations/shared/components/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../utils.dart';
import '../shared/components/incrementor.dart';
import '../shared/components/input-text.dart';
import '../shared/components/label-name.dart';
import '../shared/components/label-value.dart';
import 'payment-gateway.dart';
import 'package:http/http.dart' as http;

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  var rnd = Random().nextInt(900000).toString();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final TextEditingController itemNameController =
      TextEditingController(text: 'Spark Plug');
  final TextEditingController orderNumberController = TextEditingController();

  String orderNumber = '';
  String imgUrl =
      'https://firebasestorage.googleapis.com/v0/b/automobile-spare-parts-app.appspot.com/o/images%2F1679407761082?alt=media&token=243f3f65-4201-4b90-951f-5f38d2efc427';
  String itemId = '';
  String itemName = 'Spark Plug';
  String itemPrice = '300';
  var quantity = '';
  var totalPrice = '';
  var deliveryAddress = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    orderNumber = 'ORD - $rnd';
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
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                    width: double.infinity,
                    height: 240 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * fem),
                      color: Colors.white,
                    ),
                    child: Image.network(imgUrl),
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
                                quantity = value.toString();
                                var totPrice =
                                    int.parse(itemPrice) * int.parse(quantity);
                                totalPrice = totPrice.toString();
                                setState(() {
                                  totalPrice = totalPrice;
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
                              labelValue: totalPrice, disabled: false),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60 * fem,
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(10 * fem, 0 * fem, 0 * fem, 10 * fem),
                width: 50 * fem,
                height: 50 * fem,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 6, 84, 79),
                    borderRadius: BorderRadius.circular(8 * fem),
                  ),
                  child: IconButton(
                    icon: Image.asset(Constants.LOCATION_ICON),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => LocationPicker(
                                onChanged: (value) {
                                  deliveryAddress = value;
                                  setState(() {
                                    deliveryAddress = value;
                                  });
                                },
                                controller: addressController,
                              ));
                    },
                  ),
                ),
              ),
            ),
            Container(
              child: Column(children: [
                LabelName(labelName: "Delivery Address"),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 25),
                  child:
                      LabelValue(labelValue: deliveryAddress, disabled: false),
                )
              ]),
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
                    var totPrice = int.parse(itemPrice) * int.parse(quantity);
                    totalPrice = totPrice.toString();
                    final orderObj = OrderModel(
                        userId: userId,
                        orderNumber: orderNumber,
                        imgUrl: imgUrl,
                        itemId: itemId,
                        itemPrice: itemPrice,
                        itemName: itemName,
                        quantity: quantity,
                        totalPrice: totalPrice,
                        deliveryAddress: deliveryAddress);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentGateway(orderModel: orderObj)),
                    );
                  },
                  color: const Color.fromARGB(255, 6, 84, 79),
                  child: const Text(
                    "Confirm Order",
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
