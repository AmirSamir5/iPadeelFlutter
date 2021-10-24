import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_padeel/models/avaliable_slots.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/network/base_calls.dart';
import 'package:i_padeel/utils/urls.dart';

class AvaliableTimeSLotsProvider with ChangeNotifier {
  List<AvailableSlots> _locationSLots = [];
  bool _isLoading = false;
  bool _failedToLoad = false;
  Map<String, List<AvailableSlots>> loadedLocationsAvaliableSlots = {};

  List<AvailableSlots> get locationSlots => _locationSLots;
  bool get isLoading => _isLoading;
  bool get failedToLoad => _failedToLoad;

  Future<void> fetchLocationSlots(String locationId) async {
    // List<AvailableSlots>? previouslyLoadedSlots =
    //     loadedLocationsAvaliableSlots[locationId];
    // if (previouslyLoadedSlots != null) {
    //   _locationSLots = previouslyLoadedSlots;
    //   notifyListeners();
    //   return;
    // }

    // if (_isLoading) {
    //   return;
    // }
    _locationSLots.clear();
    _isLoading = true;
    _failedToLoad = false;

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
    String url = Urls.getAvaliableSlotsForDay(locationId);

    try {
      await BaseCalls.baseGetCall(url, null, {}, (response) async {
        if (response.statusCode == 200) {
          final extractedJson =
              json.decode(response.body)['available_slots'] as List;
          final List<AvailableSlots> locationSlots = extractedJson
              .map((json) => AvailableSlots.fromJson(json))
              .toList();

          loadedLocationsAvaliableSlots[locationId] = locationSlots;
          _locationSLots = locationSlots;
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

  //List.from(json['available_slots']).map((e)=>AvailableSlots.fromJson(e)).toList();
}
