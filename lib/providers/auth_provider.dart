import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:i_padeel/models/user.dart';
import 'package:i_padeel/network/base_calls.dart';
import 'package:i_padeel/providers/user_provider.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _deviceId = "";
  String _deviceOs = "";
  BuildContext? _context;
  bool _isAccountVerified = false;
  bool _isAccountAuthenticated = false;

  bool get isAccountAuthenticated {
    return _isAccountAuthenticated;
  }

  bool get isAccountVerified {
    return _isAccountVerified;
  }

  void setIsAccountVerified(bool isVerified) {
    _isAccountVerified = isVerified;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Constant.prefsUserAccessTokenKey);
    if (token != "" && token != null) {
      _isAccountAuthenticated = true;
      return true;
    }
    _isAccountAuthenticated = false;
    return false;
  }

  Future<void> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(Constant.prefsUserAccessTokenKey)) {
      String? token = prefs.getString(Constant.prefsUserAccessTokenKey);
      if (token != "" || token != null) {
        DateTime? tokenExpiryDate = DateTime.parse(
            prefs.getString(Constant.prefsTokenExpirationDateKey) as String);
        if (tokenExpiryDate.isAfter(DateTime.now())) {
          _isAccountAuthenticated = true;
          notifyListeners();
        }
      }
    }
  }

  Future<void> checkVerification() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(Constant.prefsUserIsVerifiedKey)) {
      bool? isVerified = prefs.getBool(Constant.prefsUserIsVerifiedKey);
      if (isVerified != null && isVerified) {
        _isAccountVerified = true;
        notifyListeners();
      }
    }
  }

  Future<void> _setDeviceOSAndID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      _deviceOs = "ios";
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      _deviceId = iosDeviceInfo.identifierForVendor;
    } else {
      _deviceOs = "android";
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      _deviceId = androidDeviceInfo.androidId;
    }
  }

  Future<void> login(
      String userName, String password, BuildContext context) async {
    Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = Constant.clientId;
    data['client_secret'] = Constant.clientSecret;
    data['grant_type'] = 'password';
    data['username'] = userName;
    data['password'] = password;
    try {
      await BaseCalls.basePostCall(Urls.loginUser(), null, {}, data,
          (response) async {
        final responseData = json.decode(response.body);
        if (response.statusCode == 200) {
          DateTime expiryDate =
              DateTime.now().add(Duration(seconds: responseData['expires_in']));
          final prefs = await SharedPreferences.getInstance();
          prefs.setString(
              Constant.prefsUserAccessTokenKey, responseData['access_token']);
          prefs.setString(
              Constant.prefsUserRefreshTokenKey, responseData['refresh_token']);
          prefs.setString(Constant.prefsTokenExpirationDateKey,
              expiryDate.toIso8601String());
          prefs.setString(Constant.prefsUsername, userName);
          prefs.setString(Constant.prefsPassword, password);

          // await FirebaseMessagingHelper.getToken();
          // setPushNotificationsToken();
          await Provider.of<UserProvider>(context, listen: false)
              .getUserProfile();
          _isAccountAuthenticated = true;
          notifyListeners();
        } else {
          throw HttpException(responseData['error_description']);
        }
      });
    } catch (error) {
      rethrow;
    }
  }

  Future registerUser(User user, File? file, BuildContext context) async {
    var url = Uri.parse(Urls.registerUser());

    try {
      var headers = {"Accept": "*/*", "Content-Type": "multipart/form-data"};
      var fileSizeInMB = 0.0;
      var request = http.MultipartRequest('POST', url);

      request.fields['first_name'] = user.firstName ?? "";
      request.fields['last_name'] = user.lastName ?? "";
      request.fields['mobile'] = user.phone ?? "";
      request.fields['email'] = user.email ?? "";
      request.fields['password'] = user.password ?? "";
      request.fields['gender'] = user.gender ?? "";
      request.fields['dateOfBirth'] = user.dateOfBirth ?? "";
      request.fields['rating'] =
          (user.rating == null) ? "26" : user.rating!.id.toString();

      if (file != null) {
        var multipartFile1 = await MultipartFile.fromPath(
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
        await login(user.email!, user.password!, context);
      } else {
        throw HttpException(responseData['detail']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);
    String? refreshToken = prefs.getString(Constant.prefsUserRefreshTokenKey);

    if (accessToken != null &&
        accessToken != "" &&
        refreshToken != "" &&
        refreshToken != null) {
      Map<String, dynamic> data = <String, dynamic>{};
      data['client_id'] = Constant.clientId;
      data['client_secret'] = Constant.clientSecret;
      data['grant_type'] = 'refresh_token';
      data['refresh_token'] =
          prefs.getString(Constant.prefsUserRefreshTokenKey);
      final url = Urls.refreshToken();
      try {
        final response = await retry(
            () => http
                .post(Uri.parse(url), body: data)
                .timeout(const Duration(seconds: 20)),
            retryIf: (e) => e is HttpException || e is SocketException);
        final responseData = json.decode(response.body);
        if (response.statusCode == 200) {
          DateTime expiryDate =
              DateTime.now().add(Duration(seconds: responseData['expires_in']));
          prefs.clear();
          prefs.setString(
              Constant.prefsUserAccessTokenKey, responseData['access_token']);
          prefs.setString(
              Constant.prefsUserRefreshTokenKey, responseData['refresh_token']);
          prefs.setString(Constant.prefsTokenExpirationDateKey,
              expiryDate.toIso8601String());
          _isAccountAuthenticated = true;
          //notifyListeners();
        } else {
          final prefs = await SharedPreferences.getInstance();
          prefs.clear();
          _isAccountAuthenticated = false;
          notifyListeners();
        }
      } catch (error) {
        rethrow;
      }
    }
  }

  setBuildContext(BuildContext context) {
    _context = context;
  }

  // Future<void> setPushNotificationsToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);
  //   String? fbToken = prefs.getString(Constant.prefsUserFBTokenKey);
  //   final PackageInfo info = await PackageInfo.fromPlatform();
  //   if (fbToken != null) {
  //     await _setDeviceOSAndID();
  //     String url = Urls.user_notification_token;
  //     try {
  //       if (accessToken == null) return;
  //       final response = await retry(
  //         () => http.post(Uri.parse(url), headers: {
  //           "Accept": "application/json",
  //           "Authorization": "OAuth2 " + accessToken
  //         }, body: {
  //           "device_id": _deviceId,
  //           "device_registration_id": fbToken,
  //           "device_os": _deviceOs,
  //           "app_version": info.version
  //         }).timeout(Duration(seconds: 15)),
  //         retryIf: (e) => e is SocketException || e is TimeoutException,
  //         maxAttempts: 2,
  //       );
  //       final responseData = json.decode(response.body);
  //       print(responseData);
  //       if (response.statusCode == 200) {
  //       } else if (response.statusCode == 401) {
  //         throw HttpException('401');
  //       } else {
  //         throw HttpException(responseData['detail']);
  //       }
  //     } catch (error) {
  //       print(error);
  //       throw error;
  //     }
  //   }
  // }

  // Future<void> signup(SignUpModel signup, BuildContext context) async {
  //   _context = context;
  //   final url = Urls.user_signup;
  //   Map<String, dynamic> jsonBody = signup.toJson();
  //   try {
  //     final response = await retry(
  //         () => (http.post(Uri.parse(url), body: jsonBody, headers: {
  //               "Accept": "application/json",
  //               "Content-Type": "application/x-www-form-urlencoded"
  //             }).timeout(Duration(seconds: 5))),
  //         retryIf: (e) => e is SocketException || e is TimeoutException);

  //     final responseData = json.decode(response.body);
  //     if (response.statusCode != 200) {
  //       throw HttpException(responseData['detail']);
  //     }
  //     print(response.statusCode);
  //     print(responseData);
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // Future<void> verify(String phoneNumber, String countryCode) async {
  //   String url = Urls.user_verify;
  //   Map<String, dynamic> verificationData = new Map<String, dynamic>();
  //   verificationData['country_code'] = countryCode;
  //   verificationData['mobile'] = phoneNumber;
  //   try {
  //     final response = await retry(
  //         () => http
  //             .post(Uri.parse(url), body: verificationData)
  //             .timeout(Duration(seconds: 5)),
  //         retryIf: (e) => e is SocketException || e is TimeoutException);
  //     final responseData = json.decode(response.body);
  //     print('respone data is: ' + responseData.toString());
  //     if (response.statusCode == 200) {
  //       _isAccountVerified = true;
  //       final prefs = await SharedPreferences.getInstance();
  //       prefs.setBool(Constant.prefsUserIsVerifiedKey, true);
  //       notifyListeners();
  //     } else {
  //       throw HttpException(responseData['details']);
  //     }
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  Future<void> logoutUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _isAccountAuthenticated = false;
    notifyListeners();
    // _context = context;
    // await _setDeviceOSAndID();
    // final prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);
    // String url = Urls.user_logout;
    // try {
    //   if (accessToken != null) {
    //     final response = await retry(
    //         () => http.post(Uri.parse(url), headers: {
    //               "Accept": "application/json",
    //               "Authorization": "OAuth2 " + accessToken
    //             }, body: {
    //               "device_id": _deviceId
    //             }).timeout(Duration(seconds: 5)),
    //         retryIf: (e) => e is SocketException || e is TimeoutException);
    //     if (response.statusCode == 200 || response.statusCode == 401) {
    //       prefs.clear();
    //       _isAccountAuthenticated = false;
    //       notifyListeners();
    //     } else {
    //       throw HttpException('Sorry, an unexpected error has occurred.');
    //     }
    //   } else {
    //     throw HttpException('Sorry, an unexpected error has occurred.');
    //   }
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
  }
}
