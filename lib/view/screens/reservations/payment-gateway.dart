import 'package:automobile_spare_parts_app/view/screens/articles/articles-create.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/place-order.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/shared/input-field.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';
import 'shared/label-name.dart';
import 'shared/label-value.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({super.key});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  int _selectedAppBarIconIndex = 1;
  final TextEditingController cardNoController = TextEditingController();
  final TextEditingController nameOnCardController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void _appBarIconTap(int index) {
    setState(() {
      _selectedAppBarIconIndex = index;
    });
  }

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
      // appBar: AppBar(backgroundColor: Colors.green, title: Text('')), // App Bar
      body: Column(
        children: [
          Container(
            height: 70 * fem,
            width: double.infinity,
            color: Colors.green,
          ),
          Container(
            // Heading place order and back arrow
            margin: EdgeInsets.fromLTRB(33 * fem, 0 * fem, 155 * fem, 0 * fem),
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
                    'assets/page-1/images/icon-arrow-left-1-3tC.png',
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
                color: const Color(0xff5db075),
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
                    'assets/page-1/images/icons8-mastercard-480-1-B1A.png',
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
                    'assets/page-1/images/icons8-visa-480-1-ijS.png',
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
                    'assets/page-1/images/icons8-paypal-64-1-JoS.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 40 * fem, 240 * fem, 22 * fem),
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
          InputField(
              labelName: 'Card No',
              enabled: true,
              controller: cardNoController,
              hint: 'Enter name on Card'),
          InputField(
              labelName: 'Name on Card',
              enabled: true,
              controller: nameOnCardController,
              hint: 'Enter name on Card'),
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
                      InputField(
                          enabled: true,
                          controller: cvvController,
                          hint: 'CVV',
                          labelName: 'CVV')
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(15 * fem, 5 * fem, 0 * fem, 0 * fem),
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
                        icon: Image.asset(
                            'assets/page-1/images/icons8-calendar-48.png'),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(88 * fem, 0 * fem, 87 * fem, 60 * fem),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PlaceOrder()),
                  );
                },
                color: const Color(0xff5db075),
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

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xff5db075),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: _selectedAppBarIconIndex == 0
                  ? Image.asset('assets/appbar/article_filled.png')
                  : Image.asset('assets/appbar/article.png'),
              onPressed: () {
                _appBarIconTap(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Scene()),
                );
              },
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 1
                  ? Image.asset('assets/appbar/market_filled.png')
                  : Image.asset('assets/appbar/market.png'),
              onPressed: () => _appBarIconTap(1),
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 2
                  ? Image.asset('assets/appbar/reservation_filled.png')
                  : Image.asset('assets/appbar/reservation.png'),
              onPressed: () {
                _appBarIconTap(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlaceOrder()),
                );
              },
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 3
                  ? Image.asset('assets/appbar/profile_filled.png')
                  : Image.asset('assets/appbar/profile.png'),
              onPressed: () => _appBarIconTap(3),
            ),
          ],
        ),
      ),
    );
  }
}
