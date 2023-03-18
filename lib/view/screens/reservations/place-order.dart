import 'package:automobile_spare_parts_app/view/screens/articles/articles-create.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';
import 'shared/label-name.dart';
import 'shared/label-value.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  int _selectedAppBarIconIndex = 1;

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
                  'Place Order',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 24 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // Image of the item
            margin: EdgeInsets.fromLTRB(149 * fem, 0 * fem, 157 * fem, 0 * fem),
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
          Container(
            // input fields
            margin:
                EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32.41 * fem, 22 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LabelName(labelName: 'Order Number'),
                LabelValue(
                  labelValue: 'ORD-R1297NH-879DNb',
                  disabled: true,
                )
              ],
            ),
          ),
          Container(
            // input fields
            margin:
                EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32.41 * fem, 22 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LabelName(labelName: 'Item Name'),
                LabelValue(
                  labelValue: 'Item 1',
                  disabled: true,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32 * fem, 25 * fem),
            width: double.infinity,
            height: 79.36 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 17 * fem, 0 * fem),
                  width: 140 * fem,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LabelName(labelName: 'Quantity'),
                      LabelValue(labelValue: '2', disabled: false)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0.36 * fem, 0 * fem, 0 * fem),
                  width: 224 * fem,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LabelName(labelName: 'Unit Price(LKR)'),
                      LabelValue(labelValue: '48500.00', disabled: false)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32 * fem, 30 * fem),
            width: double.infinity,
            height: 79.36 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 17 * fem, 0 * fem),
                  width: 300 * fem,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LabelName(labelName: 'Delivery Address'),
                      LabelValue(
                          labelValue: '110/2B, Kaduwela Road, Kaduwela',
                          disabled: false)
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 17 * fem, 0 * fem, 0 * fem),
                  width: 50 * fem,
                  height: 50 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff5db075),
                      borderRadius: BorderRadius.circular(8 * fem),
                    ),
                    child: IconButton(
                      icon:
                          Image.asset('assets/page-1/images/icon-location.png'),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(88 * fem, 0 * fem, 87 * fem, 58 * fem),
            width: double.infinity,
            height: 45 * fem,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30 * fem),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff5db075),
                borderRadius: BorderRadius.circular(30 * fem),
              ),
              child: Center(
                child: Text(
                  'Confirm Order',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.3333333333 * ffem / fem,
                    letterSpacing: 0.150000006 * fem,
                    color: Color(0xffffffff),
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
