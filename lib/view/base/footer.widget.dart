import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      // autogroupb6qufSp (2G1cqYYSRWhPBGwen2B6qu)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 0 * fem),
      padding:
          EdgeInsets.fromLTRB(30 * fem, 18 * fem, 27.34 * fem, 18.89 * fem),
      width: double.infinity,
      height: 83 * fem,
      decoration: BoxDecoration(
        color: Color(0xff5db075),
      ),
      child: Container(
        // group28N6L (10:772)
        width: double.infinity,
        height: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              // iconmessagetextWCY (10:790)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 72 * fem, 0.11 * fem),
              width: 45 * fem,
              height: 45 * fem,
              child: Image.asset(
                'assets/page-1/images/icon-message-text-cun.png',
                width: 45 * fem,
                height: 45 * fem,
              ),
            ),
            Container(
              // iconshopoxL (10:773)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 72 * fem, 0.57 * fem),
              width: 43 * fem,
              height: 44.54 * fem,
              child: Image.asset(
                'assets/page-1/images/icon-shop-TVa.png',
                width: 43 * fem,
                height: 44.54 * fem,
              ),
            ),
            Container(
              // iconshoppingcart7CL (10:780)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 71.93 * fem, 0 * fem),
              width: 45.07 * fem,
              height: 46.11 * fem,
              child: Image.asset(
                'assets/page-1/images/icon-shopping-cart-QyN.png',
                width: 45.07 * fem,
                height: 46.11 * fem,
              ),
            ),
            Container(
              // iconuserRD2 (10:786)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0.11 * fem),
              width: 38.66 * fem,
              height: 45 * fem,
              child: Image.asset(
                'assets/page-1/images/icon-user-dQc.png',
                width: 38.66 * fem,
                height: 45 * fem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
