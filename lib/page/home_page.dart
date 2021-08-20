import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/db_helper.dart';
import 'package:restaurant_app/provider/db_provider.dart';

import 'setting_page.dart';
import 'favorite_page.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DatabaseProvider databaseProvider =
      DatabaseProvider(databaseHelper: DatabaseHelper());

  int _bottomNavIndex = 0;

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
  ];

  List<Widget> _listWidget = [
    ListPage(),
    FavoritePage(
      dbProvider: databaseProvider,
    ),
    SettingPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
