import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:i_padeel/models/ratings.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:retry/retry.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class RatingsProvider with ChangeNotifier {
  List<Ratings> _ratingsList = [];
  List<Ratings> get ratingsList {
    return _ratingsList;
  }

  Future<void> getRatings() async {
    String url = Urls.getRatings();

    try {
      final response = await retry(
          () => http.get(Uri.parse(url), headers: {}).timeout(
                const Duration(
                  seconds: 15,
                ),
              ),
          retryIf: (e) => e is SocketException || e is TimeoutException);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final extractedJson = responseData['ratings'] as List;
        final List<Ratings> loadedRatings = extractedJson
            .map((reservationsJson) => Ratings.fromJson(reservationsJson))
            .toList();
        _ratingsList = loadedRatings;
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
}
