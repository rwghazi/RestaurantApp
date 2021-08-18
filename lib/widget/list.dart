import 'package:flutter/material.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/data/model/list_model.dart';
import 'package:restaurant_app/data/api/api_service.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      leading: Hero(
        tag: restaurant.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            "${ApiService.baseUrlImg}small/${restaurant.pictureId}",
            width: 100,
            height: 110,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      subtitle: Column(
        children: [
          Row(children: [
            Icon(
              Icons.location_pin,
              size: 15,
              color: Colors.grey,
            ),
            Text(
              " " + restaurant.city,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ]),
          Row(children: [
            Icon(
              Icons.star,
              size: 15,
              color: Colors.yellow,
            ),
            Text(
              " " + restaurant.rating.toString(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ]),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant);
      },
    ));
  }
}
