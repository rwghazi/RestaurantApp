import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          'RestaurantApp',
          style: Theme.of(context).textTheme.headline5,
        ),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final List<Restaurant> restaurants =
                  restoFromJson(snapshot.data!).restaurants;
              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurants[index]);
                },
              );
            } else {
              return Text("Data tidak ditemukan");
            }
          }
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      leading: Hero(
        tag: "resto" + restaurant.pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            restaurant.pictureId,
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
        Navigator.pushNamed(context, RestaurantDetail.routeName,
            arguments: restaurant);
      },
    );
  }
}
