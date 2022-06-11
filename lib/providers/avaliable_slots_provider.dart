import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/models/avaliable_slots.dart';
import 'package:i_padeel/network/base_calls.dart';
import 'package:i_padeel/utils/urls.dart';

class AvaliableTimeSLotsProvider with ChangeNotifier {
  List<AvailableSlots> _availableSlots = [];
  List<AvailableSlots> get availableSlots {
    return _availableSlots;
  }

  Future fetchLocationSlots(String locationId) async {
    String url = Urls.getAvaliableSlotsForDay(locationId);

    try {
      await BaseCalls.baseGetCall(url, null, {}, (response) async {
        if (response.statusCode == 200) {
          final extractedJson =
              json.decode(response.body)['available_slots'] as List;
          _availableSlots = extractedJson
              .map((json) => AvailableSlots.fromJson(json))
              .toList();
          notifyListeners();
        } else if (response.statusCode == 401) {
          throw const HttpException('401');
        } else if (response.statusCode == 500) {
          throw const HttpException("Sorry, an unexpected error has occurred.");
        } else {
          throw HttpException(json.decode(response.body)['error_description']);
        }
      });
    } catch (error) {
      notifyListeners();
      rethrow;
    }
  }
}
