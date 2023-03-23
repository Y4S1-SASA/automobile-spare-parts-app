import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../../../service/order.service.dart';
import '../../../../utils.dart';
import '../shared/components/input-text.dart';
import '../shared/components/label-name.dart';
import 'order-list.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  final TextEditingController cardNoController = TextEditingController();
  final TextEditingController nameOnCardController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final OrderService _orderService = OrderService();
  DateTime selectedDate = DateTime.now();
  String cardNo = '';
  String nameOnCard = '';
  String expDate = '';
  String cvv = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      // appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 84, 79), title: Text('')), // App Bar
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
                    child: Image.asset(
                      Constants.LEFT_ARROW_ICON,
                      width: 11.65 * fem,
                      height: 26 * fem,
                    ),
                  ),
                  Text(
                    'Payment',
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
              margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 21 * fem, 9 * fem),
              child: Text(
                'We Accept',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2125 * ffem / fem,
                  color: const Color.fromARGB(255, 6, 84, 79),
                ),
              ),
            ),
            Container(
              // group65E6t (1:157)
              margin: EdgeInsets.fromLTRB(83 * fem, 0 * fem, 83 * fem, 0 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // icons8mastercard4801x2t (1:158)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 1 * fem),
                    width: 91 * fem,
                    height: 91 * fem,
                    child: Image.asset(
                      Constants.MASTERCARD_ICON,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 21 * fem,
                  ),
                  SizedBox(
                    // icons8visa4801eAc (1:159)
                    width: 92 * fem,
                    height: 92 * fem,
                    child: Image.asset(
                      Constants.VISA_ICON,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 21 * fem,
                  ),
                  Container(
                    // icons8paypal641APr (1:160)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 2 * fem),
                    width: 54 * fem,
                    height: 54 * fem,
                    child: Image.asset(
                      Constants.PAYPAL_ICON,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 40 * fem, 240 * fem, 22 * fem),
              child: Text(
                'Enter Card Details',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2125 * ffem / fem,
                  color: const Color(0xff000000),
                ),
              ),
            ),
            InputText(
              labelName: 'Card No',
              enabled: true,
              controller: cardNoController,
              hint: 'Enter name on Card',
              onChanged: (value) {
                cardNo = value;
              },
            ),
            InputText(
              labelName: 'Name on Card',
              enabled: true,
              controller: nameOnCardController,
              hint: 'Enter name on Card',
              onChanged: (value) {
                nameOnCard = value;
              },
            ),
            SizedBox(
              height: 105 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0.36 * fem, 75 * fem, 0 * fem),
                    width: 200 * fem,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputText(
                          enabled: true,
                          controller: cvvController,
                          hint: 'CVV',
                          labelName: 'CVV',
                          onChanged: (value) {
                            cvv = value;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        15 * fem, 5 * fem, 0 * fem, 0 * fem),
                    width: 120 * fem,
                    height: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            const LabelName(labelName: 'Exp. Date'),
                            Text(
                              "${"${selectedDate.toLocal()}".split('')[5]}${"${selectedDate.toLocal()}".split('')[6]}/${"${selectedDate.toLocal()}".split('')[2]}${"${selectedDate.toLocal()}".split('')[3]}",
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 2.5 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Image.asset(Constants.CALENDAR_ICON),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(88 * fem, 0 * fem, 87 * fem, 60 * fem),
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
                    var result = _orderService.createOrder(widget.orderModel);
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ERROR!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Order Placed successfully!')),
                      );
                      cardNoController.clear();
                      nameOnCardController.clear();
                      cvvController.clear();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderList()),
                    );
                  },
                  color: const Color.fromARGB(255, 6, 84, 79),
                  child: const Text(
                    "Pay Now",
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