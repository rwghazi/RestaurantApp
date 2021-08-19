import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/db_helper.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/page/favorite_page.dart';
import 'package:restaurant_app/page/home_page.dart';
import 'package:restaurant_app/page/setting_page.dart';
import 'package:restaurant_app/page/splashscreen.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/page/list_page.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/styles/text_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService(), id: ''),
          ),
          ChangeNotifierProvider(
              create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RestaurantApp',
          theme: ThemeData(
              textTheme: myTextTheme,
              primarySwatch: Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            HomePage.routeName: (context) => HomePage(),
            //ListPage.routeName: (context) => ListPage(),
            DetailPage.routeName: (context) => DetailPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
          },
        ));
  }
}
