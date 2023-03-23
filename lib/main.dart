import 'package:automobile_spare_parts_app/view/screens/auth/login.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/auth_provider.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // get an instance of SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // create AuthProvider with prefs
          create: (_) => AuthProvider(prefs: prefs),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SASA',
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          // check if the user is logged in and has data
          if (authProvider.isLoggedIn && authProvider.user != null) {
            // redirect to MarketScreen with user data
            return HomeScreen();
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color(0xff5db075),
                toolbarHeight: 10,
              ),
              body: LoginScreen(),
            );
          }
        },
      ),
    );
  }
}