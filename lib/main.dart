import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/styles/text_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
          textTheme: myTextTheme,
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        RestaurantList.routeName: (context) => RestaurantList(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
