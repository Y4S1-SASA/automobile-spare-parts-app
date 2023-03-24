import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils.dart';

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      // autogroup6kn3Pkt (2G1ckTra7XAjz6HFTq6kn3)
      margin: EdgeInsets.fromLTRB(33 * fem, 0 * fem, 143 * fem, 55 * fem),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // iconarrowleft17gt (10:750)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 98.35 * fem, 0 * fem),
            width: 11.65 * fem,
            height: 26 * fem,
            child: Image.asset(
              'assets/page-1/images/icon-arrow-left-1-u2g.png',
              width: 11.65 * fem,
              height: 26 * fem,
            ),
          ),
          Text(
            // createarticleQAC (10:682)
            'Create Article',
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
    );
  }
}
