// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/screens/order-list.dart';
import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:automobile_spare_parts_app/service/order.service.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:flutter/material.dart';
import '../shared/components/incrementor.dart';
import '../shared/components/input-text.dart';
import '../shared/components/label-name.dart';
import '../shared/components/label-value.dart';
import '../shared/components/maps.dart';

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
    addressController =
        TextEditingController(text: widget.orderModel.deliveryAddress);
    itemNameController = TextEditingController(text: currentOrder.itemName);
    orderNumberController =
        TextEditingController(text: currentOrder.orderNumber);
  }

  var quantity = '';
  var totalPrice = '';
  var deliveryAddress = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    String orderNumber = currentOrder.orderNumber;
    String imgUrl = currentOrder.imgUrl;
    String itemId = currentOrder.itemId;
    String itemName = currentOrder.itemName;
    String itemPrice = currentOrder.itemPrice;
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                const Expanded(
                  child: Text(
                    "Edit Order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
                const SizedBox(
                    width: 48), // Add some spacing to the right of the text
              ],
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
                    child: Image.network(currentOrder.imgUrl),
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
                            border: Border.all(color: Colors.white),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Incrementor(
                              //Reuse component
                              minValue: 0,
                              maxValue: 50,
                              onChanged: (value) {
                                currentOrder.quantity = value.toString();
                                var totPrice = int.parse(
                                        (currentOrder.itemPrice)
                                            .split('.')[0]) *
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelName(labelName: 'TotalPrice'),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.white,
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
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => LocationPicker(
                          onChanged: (value) {
                            currentOrder.deliveryAddress = value;
                            setState(() {
                              currentOrder.deliveryAddress = value;
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
                child: LabelValue(
                    labelValue: currentOrder.deliveryAddress, disabled: false),
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
