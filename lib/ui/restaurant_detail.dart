import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25)),
                    child: Hero(
                        tag: "resto" + restaurant.pictureId,
                        child: Image.network(
                          restaurant.pictureId,
                          width: 450,
                          height: 300,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 20),
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black.withOpacity(0.50)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.location_on,
                              color: Colors.black54,
                            ),
                            Text(
                              restaurant.city,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Tentang",
                          style: Theme.of(context).textTheme.subtitle2),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        restaurant.description,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //dash
                      Row(
                        children: List.generate(
                            150 ~/ 5,
                            (index) => Expanded(
                                  child: Container(
                                    color: index % 2 == 0
                                        ? Colors.transparent
                                        : Colors.grey,
                                    height: 2,
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Menu",
                          style: Theme.of(context).textTheme.subtitle2),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 400,
                          child: GridView.count(
                            crossAxisCount: 2,
                            primary: false,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.5,
                            children: <Widget>[
                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Makanan",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2)),
                                  Column(
                                    children: restaurant.menus.foods
                                        .map(
                                          (food) => Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                food.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              )),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text("Minuman",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2)),
                                  Column(
                                    children: restaurant.menus.drinks
                                        .map(
                                          (food) => Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                food.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              )),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                              // )
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
