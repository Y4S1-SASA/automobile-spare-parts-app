import 'package:automobile_spare_parts_app/view/screens/auth/login.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/auth_provider.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SASA',
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.isLoggedIn) {
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
      ),
    );
  }
}
