import 'package:automobile_spare_parts_app/data/models/order.model.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/components/payment-result.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/constants.dart';
import 'package:flutter/material.dart';
import '../../../../service/order.service.dart';
import '../../../../utils.dart';
import '../shared/components/input-text.dart';
import '../shared/components/label-name.dart';

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

  // Assigns the date according to the selected date.
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
                    "Payment",
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
              margin: EdgeInsets.fromLTRB(83 * fem, 0 * fem, 83 * fem, 0 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
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
              keyboardType: 'number',
              labelName: 'Card No',
              enabled: true,
              controller: cardNoController,
              hint: 'Enter Card Number',
              onChanged: (value) {
                cardNo = value;
              },
            ),
            InputText(
              keyboardType: 'text',
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
                          keyboardType: 'number',
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
                            //Need only the month and the date so filtering the text widget content accordingly
                            Text(
                              "${"${selectedDate.toLocal()}".split('')[5]}${"${selectedDate.toLocal()}".split('')[6]}/${"${selectedDate.toLocal()}".split('')[2]}${"${selectedDate.toLocal()}".split('')[3]}",
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 2.5 * ffem / fem,
                                color: Colors.blue,
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
                    if (cardNo == '' || nameOnCard == '' || cvv == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(Constants.EMPTY_FIELDS_ERROR)),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentResult(
                                  status: 'FAILED',
                                )),
                      );
                    } else {
                      var result = _orderService.createOrder(widget.orderModel);
                      // ignore: unnecessary_null_comparison
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(Constants.CREATE_ERROR)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(Constants.CREATE_SUCCESS)),
                        );
                        cardNoController.clear();
                        nameOnCardController.clear();
                        cvvController.clear();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentResult(
                                  status: 'PASSED',
                                )),
                      );
                    }
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
