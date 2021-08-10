import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  void initState() {
    super.initState();
    splashScreen();
  }

  splashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, RestaurantList.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/fast-food.png", width: 100),
            SizedBox(height: 24.0),
            Text(
              "RestaurantApp",
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
