// ignore: file_names
import 'package:flutter/material.dart';
import '../../../../../utils.dart';

class LabelValue extends StatelessWidget {
  final String labelValue;
  final bool disabled;
  const LabelValue(
      {super.key, required this.labelValue, required this.disabled});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      padding: EdgeInsets.fromLTRB(16 * fem, 19 * fem, 16 * fem, 16.48 * fem),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        labelValue,
        style: SafeGoogleFont(
          'Inter',
          fontSize: 16 * ffem,
          fontWeight: FontWeight.w500,
          height: 1.2125 * ffem / fem,
          color: disabled == true ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
