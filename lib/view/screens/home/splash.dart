import 'package:flutter/material.dart';
import 'dart:async';
import 'package:automobile_spare_parts_app/main.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: Main(),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset('assets/page-1/images/car.jpg'),
            ),
          ),
          Container(
            width: double.infinity,
            child: Image.asset('assets/page-1/images/splash-bottom.jpg'),
          ),
        ],
      ),
    );
  }
}