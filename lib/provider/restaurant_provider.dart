import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/enum.dart';

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
      final result = await apiService.getRestaurantList();
      notifyListeners();
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantResult = result;
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
      final result = await apiService.getRestaurantSearch(query);
      if (result.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ditemukan';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
