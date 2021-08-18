import 'package:restaurant_app/data/model/list_model.dart';
import 'package:restaurant_app/page/splashscreen.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/page/list_page.dart';
import 'package:restaurant_app/styles/text_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RestaurantApp #2',
      theme: ThemeData(
          textTheme: myTextTheme,
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        ListPage.routeName: (context) => ListPage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
