import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:automobile_spare_parts_app/service/order.service.dart';
import 'package:automobile_spare_parts_app/view/screens/market-items/home.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/label-name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/order.model.dart';
import '../../../utils.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<OrderModel> ordersList = [];

  @override
  void initState() {
    super.initState();
    // super.initState();
    fetchOrders();
  }

  final String userId = FirebaseAuth.instance.currentUser!.uid;
  fetchOrders() async {
    // final snapshot = await FirebaseDatabase.instance.ref('orders').get();
    final snapshot = await FirebaseDatabase.instance.ref('orders').get();
    // print(snapshot.value);
    final map = snapshot.value as Map<dynamic, dynamic>;
    // print(map);
    map.forEach((key, value) {
      if (value["userId"] == userId) {
        // print(value);
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    const _headerStyle = TextStyle(
        color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
    const _contentStyleHeader = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
    const _contentStyle = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
    final _loremIpsum =
        "Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum";

    OrderService _orderService = OrderService();

    return Scaffold(
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
                    'My Orders',
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
              margin: EdgeInsets.all(10),
              child: Accordion(
                maxOpenSections: 1,
                headerBackgroundColorOpened: Colors.black54,
                scaleWhenAnimating: true,
                openAndCloseAnimation: true,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                children: ordersList
                    .map(
                      (e) => AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.insights_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black,
                        headerBackgroundColorOpened: Colors.green,
                        header: Text(e.orderNumber, style: _headerStyle),
                        content: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 10 * fem, 10 * fem, 10 * fem),
                                  width: 200 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                  ),
                                  child: Center(
                                    // contentblockdyA (1:79)
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 139 * fem,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: const Color.fromARGB(
                                              255, 187, 186, 186),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          5, 10, 0, 0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Item Name: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            e.itemName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              e.quantity,
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
                                          margin: const EdgeInsets.fromLTRB(
                                              5, 10, 0, 0),
                                          child: const Text(
                                            'Delivery Address: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              5, 10, 0, 0),
                                          width: 240 * fem,
                                          child: Text(
                                            e.deliveryAddress,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.fromLTRB(100, 10, 100, 0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                        'assets/page-1/images/icon-edit-2 copy.png'),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                        'assets/page-1/images/icon-trash-1t4.png'),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderWidth: 1,
                        // onOpenSection: () => print('onOpenSection ...'),
                        // onCloseSection: () => print('onCloseSection ...'),
                      ),
                    )
                    .toList(),
                //   ordersList.map((e) =>
                //   Container(
                //     margin: EdgeInsets.all(0),
                //     child:
                // AccordionSection(header: const Text('Introduction', style: _headerStyle),
                //   content: Text(_loremIpsum, style: _contentStyle),
                //   contentHorizontalPadding: 20,
                //   contentBorderWidth: 1,
                // )
                // ))
              ),
            )
          ],
        ),
      ),
    );
  }
}
