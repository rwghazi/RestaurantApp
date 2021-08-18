import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/review_model.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    getRestaurantDetail(id);
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> getRestaurantDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantDetail(id);
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantResult = restaurantDetail;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> postReview(CustomerReview review) async {
    try {
      final response = await apiService.postReview(review);

      if (!response.error) getRestaurantDetail(review.id!);
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
