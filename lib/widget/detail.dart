import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/widget/review.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/provider/db_provider.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantDetailed restaurantDetailed;
  final DetailProvider detailProvider;

  const DetailRestaurant(
      {required this.restaurant,
      required this.restaurantDetailed,
      required this.detailProvider});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Material(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25)),
                            child: Hero(
                                tag: restaurant.id,
                                child: Image.network(
                                  "${ApiService.baseUrlImg}medium/" +
                                      restaurant.pictureId,
                                  width: 450,
                                  height: 300,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 15, left: 20),
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
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(top: 260, left: 20),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurantDetailed.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                          canvasColor: Colors.transparent),
                                      child: Chip(
                                        backgroundColor:
                                            Colors.amber.withOpacity(0.7),
                                        label: Text(
                                          restaurantDetailed
                                              .categories[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            width: null,
                          ),
                          Text(
                            restaurantDetailed.address,
                            style: Theme.of(context).textTheme.subtitle1,
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
                                 isFavorited
                                ? IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => provider
                                        .removeFavorites(restaurantDetailed.id),
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        provider.addFavorite(restaurant),
                                  ),
                              ]),
                          // Bagian Deskripsi
                          SizedBox(
                            height: 15,
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
                            height: 10,
                          ),

                          SizedBox(
                            height: 20,
                          ),
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
                            height: 10,
                          ),
                          Text("Review",
                              style: Theme.of(context).textTheme.subtitle2),

                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            height: 130,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  restaurantDetailed.customerReviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: SizedBox(
                                    width: 200,
                                    child: Card(
                                      elevation: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                restaurantDetailed
                                                    .customerReviews[index]
                                                    .name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                              Text(
                                                restaurantDetailed
                                                    .customerReviews[index]
                                                    .date,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '\"' +
                                                    restaurantDetailed
                                                        .customerReviews[index]
                                                        .review +
                                                    '\"',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          TextButton(
                            child: Text(
                              "Tambahkan review",
                              style: Theme.of(context).textTheme.button,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(
                                    provider: detailProvider,
                                    id: restaurantDetailed.id),
                              );
                            },
                          ),

                          SizedBox(
                            height: 10,
                          ),
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
                                        children: restaurantDetailed.menus.foods
                                            .map(
                                              (food) => Align(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                        children:
                                            restaurantDetailed.menus.drinks
                                                .map(
                                                  (food) => Align(
                                                      alignment:
                                                          Alignment.centerRight,
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
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
