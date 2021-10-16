import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retry/retry.dart';
import 'package:i_padeel/models/user.dart';
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

  void updates(AuthProvider authProvider) {
    _auth = authProvider;
  }

  Future getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken =
        prefs.getString(Constant.prefsUserAccessTokenKey) as String;
    try {
      await BaseCalls.baseGetCall(Urls.getUserProfile(), {}, {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken
      }, (response) async {
        if (response.statusCode == 200) {
          final extractData =
              json.decode(utf8.decode(response.bodyBytes))['user'];
          _user = User.fromJson(extractData);
          saveUserData(extractData, prefs);
          if (_user != null && user!.isVerified!) {
            prefs.setBool(Constant.prefsUserIsVerifiedKey, true);
          }
          _auth!.setIsAccountVerified(_user!.isVerified!);
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
      rethrow;
    }
  }

  Future editUserProfile(User user, File? file) async {
    var url = Uri.parse(Urls.editUserProfile());
    final prefs = await SharedPreferences.getInstance();
    String accessToken =
        prefs.getString(Constant.prefsUserAccessTokenKey) as String;

    try {
      var headers = {
        "Accept": "*/*",
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer " + accessToken
      };
      var fileSizeInMB = 0.0;
      var request = http.MultipartRequest('PATCH', url);

      request.fields['first_name'] = user.firstName ?? "";
      request.fields['last_name'] = user.lastName ?? "";
      request.fields['mobile'] = user.phone ?? "";
      request.fields['email'] = user.email ?? "";
      if (user.password != "") request.fields['password'] = user.password ?? "";
      request.fields['gender'] = user.gender ?? "";
      request.fields['date_of_birth'] = user.dateOfBirth ?? "";
      request.fields['rating'] =
          (user.rating == null) ? "26" : user.rating!.id.toString();

      if (file != null) {
        var multipartFile1 = await http.MultipartFile.fromPath(
            "profile_photo", file.path,
            contentType: MediaType('image', 'jpg'));
        request.files.add(multipartFile1);
        var fileSizeInBytes = file.lengthSync();
        // Convert the bytes to Kilobytes (1 KB = 1024 Bytes)
        var fileSizeInKB = fileSizeInBytes / 1024;
        // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
        fileSizeInMB += fileSizeInKB / 1024;
        print('total Size in MB: ' + fileSizeInMB.toString());
      }
      request.headers.addAll(headers);
      var response = await retry(() => request.send(),
              retryIf: (e) => e is SocketException || e is TimeoutException)
          .timeout(const Duration(seconds: 5));
      var responseStr = await response.stream.bytesToString();

      final responseData = json.decode(responseStr);

      if (response.statusCode == 200) {
        await getUserProfile();
      } else {
        throw HttpException(responseData['detail']);
      }
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
    _user = User.fromJson(json);
    notifyListeners();
    return _user;
  }
}
