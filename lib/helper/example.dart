import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '/utils.dart';

class MarketListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // itemmarketlisteC8 (10:1188)
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffececec)),
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // group4Lqe (10:1189)
              width: 445 * fem,
              height: 52.21 * fem,
              child: Image.asset(
                'assets/page-1/images/group-4-Fwv.png',
                width: 445 * fem,
                height: 52.21 * fem,
              ),
            ),
            Container(
              // autogroup7r952iU (2G1UVXwvQwfYNCvFDB7r95)
              padding:
                  EdgeInsets.fromLTRB(0 * fem, 21.79 * fem, 0 * fem, 0 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // autogroup6wepvor (2G1U1oF8v8oDnj96nz6weP)
                    margin: EdgeInsets.fromLTRB(
                        33 * fem, 0 * fem, 182 * fem, 30 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // iconarrowleft1rhW (10:1195)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 137.35 * fem, 0 * fem),
                          width: 11.65 * fem,
                          height: 26 * fem,
                          child: Image.asset(
                            'assets/page-1/images/icon-arrow-left-1.png',
                            width: 11.65 * fem,
                            height: 26 * fem,
                          ),
                        ),
                        Text(
                          // market8uv (10:1192)
                          'Market',
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
                    // addGWL (10:1193)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 34 * fem),
                    width: double.infinity,
                    child: Text(
                      'Add',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff5db075),
                      ),
                    ),
                  ),
                  Container(
                    // inputsearchBdJ (10:1194)
                    margin: EdgeInsets.fromLTRB(
                        25 * fem, 0 * fem, 24 * fem, 30 * fem),
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 20 * fem, 16 * fem, 18 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/page-1/images/bg-PqJ.png',
                        ),
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xffbdbdbd),
                      ),
                    ),
                  ),
                  Container(
                    // new16Y (10:1501)
                    margin: EdgeInsets.fromLTRB(
                        25 * fem, 0 * fem, 0 * fem, 17 * fem),
                    child: Text(
                      'New',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // group43iWk (10:1510)
                    margin: EdgeInsets.fromLTRB(
                        32 * fem, 0 * fem, 31 * fem, 29 * fem),
                    width: double.infinity,
                    height: 177 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // contentmarketblockdtc (10:1497)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 28 * fem, 0 * fem),
                          width: 110 * fem,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // rectangle30mE8 (I10:1497;151:68)
                                width: double.infinity,
                                height: 110 * fem,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8 * fem),
                                  color: Color(0xfff6f6f6),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Container(
                                // item1namegoesheregrt (I10:1497;151:69)
                                constraints: BoxConstraints(
                                  maxWidth: 83 * fem,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Item 1 Name\n',
                                      ),
                                      TextSpan(
                                        text: 'Body kit',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Text(
                                // uNG (I10:1497;151:74)
                                'LKR24000.00',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // contentmarketblockFS8 (10:1502)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 24 * fem, 0 * fem),
                          width: 110 * fem,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // rectangle30P2Y (I10:1502;151:68)
                                width: double.infinity,
                                height: 110 * fem,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8 * fem),
                                  color: Color(0xfff6f6f6),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Container(
                                // item1namegoeshereJ9W (I10:1502;151:69)
                                constraints: BoxConstraints(
                                  maxWidth: 85 * fem,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Item 2 Name\n',
                                      ),
                                      TextSpan(
                                        text: 'Engine',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Text(
                                // dqz (I10:1502;151:74)
                                'LKR16000.00',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // contentmarketblockmxC (10:1506)
                          width: 110 * fem,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // rectangle306Dn (I10:1506;151:68)
                                width: double.infinity,
                                height: 110 * fem,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8 * fem),
                                  color: Color(0xfff6f6f6),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Container(
                                // item1namegoesherechv (I10:1506;151:69)
                                constraints: BoxConstraints(
                                  maxWidth: 85 * fem,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Item 3 Name\n',
                                      ),
                                      TextSpan(
                                        text: 'Liquid',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Text(
                                // oXW (I10:1506;151:74)
                                'LKR6000.00',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // trendingYzt (10:1511)
                    margin: EdgeInsets.fromLTRB(
                        25 * fem, 0 * fem, 0 * fem, 17 * fem),
                    child: Text(
                      'Trending',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // group443Rr (10:1512)
                    margin: EdgeInsets.fromLTRB(
                        32 * fem, 0 * fem, 31 * fem, 20 * fem),
                    width: double.infinity,
                    height: 177 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // contentmarketblockAmN (10:1513)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 28 * fem, 0 * fem),
                          width: 110 * fem,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // rectangle30Voe (I10:1513;151:68)
                                width: double.infinity,
                                height: 110 * fem,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8 * fem),
                                  color: Color(0xfff6f6f6),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Container(
                                // item1namegoesherePu2 (I10:1513;151:69)
                                constraints: BoxConstraints(
                                  maxWidth: 85 * fem,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Item 4 Name\n',
                                      ),
                                      TextSpan(
                                        text: 'Coil',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Text(
                                // LBz (I10:1513;151:74)
                                'LKR99000.00',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // contentmarketblockFpk (10:1514)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 24 * fem, 0 * fem),
                          width: 110 * fem,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // rectangle30yVr (I10:1514;151:68)
                                width: double.infinity,
                                height: 110 * fem,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8 * fem),
                                  color: Color(0xfff6f6f6),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Container(
                                // item1namegoeshere76G (I10:1514;151:69)
                                constraints: BoxConstraints(
                                  maxWidth: 85 * fem,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Item 5 Name\n',
                                      ),
                                      TextSpan(
                                        text: 'Air Spray',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Text(
                                // 5BW (I10:1514;151:74)
                                'LKR200.00',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // contentmarketblockDoW (10:1515)
                          width: 110 * fem,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // rectangle30wjW (I10:1515;151:68)
                                width: double.infinity,
                                height: 110 * fem,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8 * fem),
                                  color: Color(0xfff6f6f6),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Container(
                                // item1namegoeshereffW (I10:1515;151:69)
                                constraints: BoxConstraints(
                                  maxWidth: 85 * fem,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Item 6 Name\n',
                                      ),
                                      TextSpan(
                                        text: 'Video Player',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8 * fem,
                              ),
                              Text(
                                // e1e (I10:1515;151:74)
                                'LKR46000.00',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupsuekzLQ (2G1U7xjXv6KjhH6F7FSUeK)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 0 * fem),
                    width: double.infinity,
                    height: 249 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // group45Vnx (10:1525)
                          left: 32 * fem,
                          top: 0 * fem,
                          child: Container(
                            width: 382 * fem,
                            height: 177 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // contentmarketblock1WQ (10:1526)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 28 * fem, 0 * fem),
                                  width: 110 * fem,
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // rectangle30jhJ (I10:1526;151:68)
                                        width: double.infinity,
                                        height: 110 * fem,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: Color(0xfff6f6f6),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Container(
                                        // item1namegoesheresoW (I10:1526;151:69)
                                        constraints: BoxConstraints(
                                          maxWidth: 84 * fem,
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xff000000),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Item 7 Name\n',
                                              ),
                                              TextSpan(
                                                text: 'Coil',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 14 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Text(
                                        // UYQ (I10:1526;151:74)
                                        'LKR99000.00',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // contentmarketblockE1n (10:1527)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 24 * fem, 0 * fem),
                                  width: 110 * fem,
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // rectangle308N4 (I10:1527;151:68)
                                        width: double.infinity,
                                        height: 110 * fem,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: Color(0xfff6f6f6),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Container(
                                        // item1namegoesheree5W (I10:1527;151:69)
                                        constraints: BoxConstraints(
                                          maxWidth: 85 * fem,
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xff000000),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Item 8 Name\n',
                                              ),
                                              TextSpan(
                                                text: 'Air Spray',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 14 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Text(
                                        // 2Lx (I10:1527;151:74)
                                        'LKR200.00',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // contentmarketblockxkQ (10:1528)
                                  width: 110 * fem,
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // rectangle30JZN (I10:1528;151:68)
                                        width: double.infinity,
                                        height: 110 * fem,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: Color(0xfff6f6f6),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Container(
                                        // item1namegoeshered5r (I10:1528;151:69)
                                        constraints: BoxConstraints(
                                          maxWidth: 85 * fem,
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xff000000),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Item 9 Name\n',
                                              ),
                                              TextSpan(
                                                text: 'Video Player',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 14 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Text(
                                        // cCg (I10:1528;151:74)
                                        'LKR46000.00',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // rectangle141ZNp (10:1263)
                          left: 0 * fem,
                          top: 166 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 445 * fem,
                              height: 83 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff5db075),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
