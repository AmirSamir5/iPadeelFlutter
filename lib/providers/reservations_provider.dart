import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:i_padeel/models/reservation.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:retry/retry.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationsProvider with ChangeNotifier {
  // final String authToken;
  List<Reservation> _reservationsList = [];

  String? authToken;

  List<Reservation> get reservationsList {
    return _reservationsList;
  }

  Future<void> loadReservations() async {
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);

    String url = Urls.getReservationsList();

    try {
      if (accessToken == null) {
        throw const HttpException('Something Went Wrong!');
      }
      final response = await retry(
          () => http.get(Uri.parse(url), headers: {
                "Accept": "application/json",
                "Authorization": "Bearer " + accessToken
              }).timeout(
                const Duration(
                  seconds: 15,
                ),
              ),
          retryIf: (e) => e is SocketException || e is TimeoutException);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final extractedJson = responseData['reservations'] as List;
        final List<Reservation> loadedReservations = extractedJson
            .map((reservationsJson) => Reservation.fromJson(reservationsJson))
            .toList();
        _reservationsList = loadedReservations;
        notifyListeners();
      } else if (response.statusCode == 401) {
        throw const HttpException('401');
      } else if (response.statusCode == 500) {
        throw const HttpException("Sorry, an unexpected error has occurred.");
      } else {
        throw HttpException(json.decode(response.body)['error_description']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteReservations(String resId) async {
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);

    String url = Urls.deleteReservations(resId);

    try {
      if (accessToken == null) {
        throw const HttpException('Something Went Wrong!');
      }
      final response = await retry(
          () => http.delete(Uri.parse(url), headers: {
                "Accept": "application/json",
                "Authorization": "Bearer " + accessToken
              }).timeout(
                const Duration(
                  seconds: 15,
                ),
              ),
          retryIf: (e) => e is SocketException || e is TimeoutException);
      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        _reservationsList.removeWhere((element) => element.guid == resId);
        notifyListeners();
      } else if (response.statusCode == 401) {
        throw const HttpException('401');
      } else if (response.statusCode == 500) {
        throw const HttpException("Sorry, an unexpected error has occurred.");
      } else {
        throw HttpException(json.decode(response.body)['detail']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
