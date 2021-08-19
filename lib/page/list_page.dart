import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/list.dart';
import 'package:restaurant_app/utils/enum.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late RestaurantProvider provider;
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBar = Text(
    'RestaurantApp',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _appBar,
        leading: IconButton(
          icon: _searchIcon,
          iconSize: 30,
          onPressed: _search,
        ),
      ),
      body: _buildItem(context),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        provider = state;
        if (state.state == ResultState.Loading) {
          return Center(
            child: SpinKitHourGlass(color: Colors.amber),
          );
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-wifi.png", width: 100),
              SizedBox(
                height: 10,
              ),
              Text("Koneksi terputus!"),
              ElevatedButton(
                child: Text("refresh"),
                onPressed: () {
                  provider.getAllRestaurants();
                },
              ),
            ],
          ));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  void _search() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBar = TextField(
          controller: _filter,
          cursorColor: Colors.white,
          decoration: InputDecoration(hintText: 'Cari nama restoran'),
          onChanged: (query) => {
            if (query != '')
              {
                provider.getRestaurantSearch(query),
              }
          },
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBar = Text('RestaurantApp #2',
            style: Theme.of(context).textTheme.headline5);
        provider.getAllRestaurants();
        _filter.clear();
      }
    });
  }
}
