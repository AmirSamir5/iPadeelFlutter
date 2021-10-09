import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/models/reservation.dart';
import 'package:i_padeel/network/base_calls.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  AuthProvider? _auth;
  User? _user;
  User? get user {
    if (_user == null) return null;
    return _user!;
  }

  UserProvider(this._auth);

  Future getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken =
        prefs.getString(Constant.prefsUserAccessTokenKey) as String;
    try {
      await BaseCalls.basePostCall(Urls.getUserProfile(), {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      }, {}, {}, (response) async {
        if (response.statusCode == 200) {
          final extractData =
              json.decode(utf8.decode(response.bodyBytes))['user'];
          _user = User.fromJson(extractData);
          saveUserData(extractData, prefs);
          if (_user != null && user!.isVerified) {
            prefs.setBool(Constant.prefsUserIsVerifiedKey, true);
          }
          _auth!.setIsAccountVerified(_user!.isVerified);
        } else if (response.statusCode == 401) {
          throw const HttpException('401');
        } else if (response.statusCode == 500) {
          throw const HttpException("Sorry, an unexpected error has occurred.");
        } else {
          throw HttpException(json.decode(response.body)['error_description']);
        }
      });
    } catch (error) {
      rethrow;
    }
  }

  void saveUserData(dynamic extractData, SharedPreferences prefs) {
    final encodedUser = jsonEncode(User.fromJson(extractData));
    prefs.setString(Constant.prefsUserKey, encodedUser);
  }

  Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Constant.prefsUserKey) == null) return null;
    Map<String, dynamic> json =
        jsonDecode(prefs.getString(Constant.prefsUserKey)!);
    return User.fromJson(json);
  }
}
