import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/network/base_calls.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LocationsProvider with ChangeNotifier {
  List<Location> _locations = [];
  bool _isLoading = false;
  bool _failedToLoad = false;

  List<Location> get locations => _locations;
  bool get isLoading => _isLoading;
  bool get failedToLoad => _failedToLoad;

  Future<void> fetchLocations() async {
    if (_isLoading) {
      return;
    }
    _locations.clear();
    _isLoading = true;
    _failedToLoad = false;

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
    String url = Urls.getLocations;

    try {
      await BaseCalls.baseGetCall(url, null, {}, (response) async {
        final responseData = json.decode(response.body);
        if (response.statusCode == 200) {
          final extractedJson = json.decode(response.body)['location'] as List;
          final List<Location> loadedLocations =
              extractedJson.map((json) => Location.fromJson(json)).toList();

          _locations = loadedLocations;
          _failedToLoad = false;
          _isLoading = false;
          notifyListeners();
        } else {
          _isLoading = false;
          _failedToLoad = true;
          notifyListeners();
        }
      });
    } catch (error) {
      _isLoading = false;
      _failedToLoad = true;
      notifyListeners();
      rethrow;
    }
  }
}
