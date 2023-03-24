// ignore: depend_on_referenced_packages
import 'package:automobile_spare_parts_app/data/models/item.model.dart';
// ignore_for_file: depend_on_referenced_packages
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:automobile_spare_parts_app/data/models/item.model.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/components/maps.dart';
import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:flutter/material.dart';
import '../shared/components/incrementor.dart';
import '../shared/components/input-text.dart';
import '../shared/components/label-name.dart';
import '../shared/components/label-value.dart';
import 'payment-gateway.dart';

class PlaceOrder extends StatefulWidget {
  PlaceOrder({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  var rnd = Random().nextInt(900000).toString(); // Gnerate random numbers
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();

  var quantity = '';
  var totalPrice = '';
  var deliveryAddress = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    String orderNumber = 'ORD - $rnd';
    String imgUrl = widget.itemModel.imageUrl;
    String itemId = widget.itemModel.id;
    String itemName = widget.itemModel.name;
    double itemValue = widget.itemModel.price;
    String itemPrice = itemValue.toString();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70 * fem,
              width: double.infinity,
              color: const Color.fromARGB(255, 6, 84, 79),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: Text(
                    "Place Order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(149 * fem, 0 * fem, 157 * fem, 35 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8 * fem),
              ),
              child: Center(
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
                keyboardType: 'text',
                onChanged: (value) {
                  orderNumber = orderNumber;
                },
                labelName: 'Order Number',
                hint: orderNumber,
                enabled: false,
                controller: orderNumberController),
            InputText(
                keyboardType: 'text',
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
                              maxValue: widget.itemModel.quantity,
                              onChanged: (value) {
                                quantity = value.toString();
                                var totPrice =
                                    int.parse((itemPrice).split('.')[0]) *
                                        int.parse(quantity);
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelName(labelName: 'Unit Price (LKR)'),
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
            GestureDetector(
              onTap: () {
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
              child: SizedBox(
                height: 60 * fem,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      25 * fem, 0 * fem, 25 * fem, 10 * fem),
                  width: double.infinity,
                  height: 40 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 74, 76, 76),
                      borderRadius: BorderRadius.circular(8 * fem),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            Constants.LOCATION_ICON,
                            height: 20,
                            width: 20,
                          ),
                          onPressed: () {},
                        ),
                        const Text("Pick Location",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'Inter',
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: EdgeInsets.fromLTRB(
                      32 * fem, 5 * fem, 32.41 * fem, 0 * fem),
                  child: const LabelName(labelName: "Delivery Address")),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 3, 25, 25),
                child: LabelValue(labelValue: deliveryAddress, disabled: false),
              )
            ]),
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
                    var totPrice = int.parse((itemPrice).split('.')[0]) *
                        int.parse(quantity);
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
