// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../service/order.service.dart';
import '../../../../../utils.dart';
import '../../screens/order-list.dart';
import '../constants.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key, required this.orderId});
  final String? orderId;

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final OrderService _orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SimpleDialog(
      title: const Text(Constants.DELETE_ORDER_TITLE),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 30 * fem),
          width: 110 * fem,
          height: 110 * fem,
          child: Image.asset(
            Constants.CLOSE_CIRCLE_ICON,
            width: 107.14 * fem,
            height: 127.54 * fem,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(26 * fem, 0 * fem, 18 * fem, 0 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30 * fem),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(7.14 * fem, 0 * fem, 0 * fem, 30 * fem),
                child: Text(
                  Constants.DELETE_ORDER_CONFIRMATION,
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
                // Delete Button
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
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
                        _orderService.deleteOrder(widget.orderId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderList()),
                        );
                      },
                      child: Text(
                        'Delete Order',
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
                // Cancel Button
                width: double.infinity,
                height: 45 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30 * fem),
                ),
                child: Container(
                  // group5JAk (1:303)
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff636363),
                    borderRadius: BorderRadius.circular(30 * fem),
                  ),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 18 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.3333333333 * ffem / fem,
                        letterSpacing: 0.150000006 * fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
