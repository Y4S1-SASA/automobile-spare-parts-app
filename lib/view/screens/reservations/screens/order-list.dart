// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:automobile_spare_parts_app/service/order.service.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/order.model.dart';
import '../shared/components/delete-dialog.dart';
import 'order-edit.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final OrderService _orderService = OrderService();
  List<OrderModel> ordersList = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Method fetchs orders from the real time database and stores the orders relavant to the current user.
  fetchOrders() async {
    final snapshot = await _orderService.orderCollection.get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      if (value["userId"] == userId) {
        OrderModel order = OrderModel(
            orderId: key,
            userId: value["userId"],
            orderNumber: value["orderNumber"],
            imgUrl: value["imgUrl"],
            itemId: value["itemId"],
            itemPrice: value["itemPrice"],
            itemName: value["itemName"],
            quantity: value["quantity"],
            totalPrice: value["totalPrice"],
            deliveryAddress: value["deliveryAddress"]);
        setState(() {
          ordersList.add(order);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    const headerStyle = TextStyle(
        color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
    return ordersList.isNotEmpty
        ? Scaffold(
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
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "My Reservations",
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
                          width:
                              48), // Add some spacing to the right of the text
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Accordion(
                      maxOpenSections: 1,
                      headerBackgroundColorOpened: Colors.black54,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: ordersList
                          .map(
                            (order) => AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.insights_rounded,
                                  color: Colors.white),
                              headerBackgroundColor: Colors.black,
                              headerBackgroundColorOpened:
                                  const Color.fromARGB(255, 6, 84, 79),
                              header:
                                  Text(order.orderNumber, style: headerStyle),
                              content: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            10 * fem, 10 * fem, 10 * fem),
                                        width: 200 * fem,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 139 * fem,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem),
                                              width: double.infinity,
                                              height: 240 * fem,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8 * fem),
                                                color: Colors.white,
                                              ),
                                              child:
                                                  Image.network(order.imgUrl),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 10, 0, 0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Item Name: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  order.itemName,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 10, 0, 0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Quantity: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    order.quantity,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 10, 0, 0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Total Price: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'Rs.${order.totalPrice}.00',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 10, 0, 0),
                                                child: const Text(
                                                  'Delivery Address: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 10, 0, 0),
                                                width: 370 * fem,
                                                child: Text(
                                                  order.deliveryAddress,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        100, 10, 100, 0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon:
                                              Image.asset(Constants.EDIT_ICON),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditOrder(
                                                        orderModel: order,
                                                      )),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Image.asset(
                                              Constants.DELETE_ICON),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    DeleteDialog(
                                                        orderId:
                                                            order.orderId));
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
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
                        "My Reservations",
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
                Center(
                    child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 150),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 30 * fem),
                                width: 110 * fem,
                                height: 110 * fem,
                                child: Image.asset(
                                  Constants.NO_DATA_FOUND_ICON,
                                  width: 107.14 * fem,
                                  height: 127.54 * fem,
                                ),
                              ),
                              const Text(
                                Constants.NO_ORDERS,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontFamily: "Inter",
                                ),
                              ),
                              const SizedBox(height: 100),
                            ])))
              ]),
            ),
          );
  }
}
