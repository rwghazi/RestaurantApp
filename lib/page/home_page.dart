import 'package:flutter/material.dart';
import 'setting_page.dart';
import 'favorite_page.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  final int bottomNavBarIndex;

  const HomePage({this.bottomNavBarIndex = 0});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int bottomNavBarIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  Widget customNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)]),
          child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.grey.shade400,
              currentIndex: bottomNavBarIndex,
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                    label: "Beranda",
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 20,
                      child: Icon(Icons.home),
                    )),
                BottomNavigationBarItem(
                    label: "Favorit",
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 20,
                      child: Icon(Icons.favorite),
                    )),
                BottomNavigationBarItem(
                    label: "Setting",
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 20,
                      child: Icon(Icons.settings),
                    )),
              ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.amber,
          ),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
            },
            children: [
              ListPage(),
              FavoritePage(),
              SettingPage(),
            ],
          ),
          customNavBar()
        ],
      ),
    );
  }
}
