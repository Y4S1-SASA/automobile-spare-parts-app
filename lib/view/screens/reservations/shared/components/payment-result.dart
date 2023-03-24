// ignore_for_file: depend_on_referenced_packages
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/screens/order-list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../utils.dart';
import '../constants.dart';

class PaymentResult extends StatefulWidget {
  const PaymentResult({super.key, required this.status});
  final String status;

  @override
  State<PaymentResult> createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return widget.status == 'PASSED'
        ? SimpleDialog(
            contentPadding: const EdgeInsets.all(20),
            children: [
              Container(
                // Shield Tick Image
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 30 * fem),
                width: 110 * fem,
                height: 110 * fem,
                child: Image.asset(
                  Constants.SHEILD_TICK,
                  width: 107.14 * fem,
                  height: 127.54 * fem,
                ),
              ),
              Container(
                // Description
                margin:
                    EdgeInsets.fromLTRB(26 * fem, 0 * fem, 18 * fem, 0 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          7.14 * fem, 0 * fem, 0 * fem, 30 * fem),
                      child: Text(
                        Constants.PAYMENT_VERIFIED,
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w300,
                          height: 1.2125 * ffem / fem,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      // Reservation Button
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      width: double.infinity,
                      height: 45 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(30 * fem),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OrderList()),
                              );
                            },
                            child: Text(
                              'My Reservations',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333 * ffem / fem,
                                letterSpacing: 0.150000006 * fem,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // Home button
                      width: double.infinity,
                      height: 45 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(30 * fem),
                        ),
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          child: Text(
                            'Go to Home',
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.3333333333 * ffem / fem,
                              letterSpacing: 0.150000006 * fem,
                              color: Colors.white,
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : (SimpleDialog(
            contentPadding: const EdgeInsets.all(20),
            children: [
              Container(
                // Payment Failed Section
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 30 * fem),
                width: 110 * fem,
                height: 110 * fem,
                child: Image.asset(
                  Constants.CLOSE_CIRCLE_ICON,
                  width: 107.14 * fem,
                  height: 127.54 * fem,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(26 * fem, 0 * fem, 18 * fem, 0 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          7.14 * fem, 0 * fem, 0 * fem, 30 * fem),
                      child: Text(
                        Constants.PAYMENT_FAILED,
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w300,
                          height: 1.2125 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      // Retry payment button
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      width: double.infinity,
                      height: 45 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(30 * fem),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Retry Payment',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333 * ffem / fem,
                                letterSpacing: 0.150000006 * fem,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 45 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(30 * fem),
                        ),
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          child: Text(
                            'Go to Home',
                            style: SafeGoogleFont('Inter',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333 * ffem / fem,
                                letterSpacing: 0.150000006 * fem,
                                color: Colors.white),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
  }
}
