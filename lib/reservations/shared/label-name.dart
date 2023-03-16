import 'package:flutter/material.dart';
import '../../utils.dart';

class LabelName extends StatelessWidget {
  final String labelName;
  const LabelName({super.key, required this.labelName});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8.52 * fem),
      child: Text(
        labelName,
        style: SafeGoogleFont(
          'Inter',
          fontSize: 12 * ffem,
          fontWeight: FontWeight.w400,
          height: 1.2125 * ffem / fem,
          color: const Color(0xff666666),
        ),
      ),
    );
  }
}
