import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/common/enum.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantProvider({required this.apiService, required this.id}) {
    getAllRestaurants();
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> getAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantList();
      notifyListeners();
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantResult = restaurantList;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> getRestaurantSearch(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantSearch = await apiService.getRestaurantSearch(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ditemukan';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
