import 'package:automobile_spare_parts_app/helper/example.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-create.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-create.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-list.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/profile/user-profile.dart';
import 'package:automobile_spare_parts_app/view/screens/item/save.item.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/screens/order-list.dart';
import 'package:flutter/material.dart';
import './../item/item.market.list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedAppBarIconIndex = 1;

  void _appBarIconTap(int index) {
    setState(() {
      _selectedAppBarIconIndex = index;
    });
  }

  Widget _getBody(index) {
    switch (index) {
      case 0:
        return ListArticles();
        break;
      case 1:
        return ItemMarketList();
        break;
      case 2:
        return OrderList();
        break;
      case 3:
        return ProfileScreen();
        break;
      default:
        return ItemMarketList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(_selectedAppBarIconIndex),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color.fromARGB(255, 6, 84, 79),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: _selectedAppBarIconIndex == 0
                  ? Image.asset('assets/appbar/article_filled.png')
                  : Image.asset('assets/appbar/article.png'),
              onPressed: () {
                _appBarIconTap(0);
              },
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 1
                  ? Image.asset('assets/appbar/market_filled.png')
                  : Image.asset('assets/appbar/market.png'),
              onPressed: () => _appBarIconTap(1),
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 2
                  ? Image.asset('assets/appbar/reservation_filled.png')
                  : Image.asset('assets/appbar/reservation.png'),
              onPressed: () {
                _appBarIconTap(2);
              },
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 3
                  ? Image.asset('assets/appbar/profile_filled.png')
                  : Image.asset('assets/appbar/profile.png'),
              onPressed: () {
                _appBarIconTap(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}