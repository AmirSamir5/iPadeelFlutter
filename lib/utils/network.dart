import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'dart:developer';

class CallDetails {
  String url;
  Map<String, String> queryStrings;
  Map<String, String> headers;
  Map<String, dynamic> body;
  CallDetails({
    required this.url,
    required this.queryStrings,
    required this.headers,
    required this.body,
  });
}

class BaseCalls {
  static Future<dynamic> baseGetCall(
      String url,
      Map<String, String> queryStrings,
      Map<String, String> headers,
      dynamic Function(dynamic) parse) async {
    var updatedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };
    var modifiedUrl = addHeaderstoUrl(url, queryStrings);
    var callDetails = CallDetails(
        url: modifiedUrl,
        queryStrings: queryStrings,
        headers: updatedHeaders,
        body: {});
    try {
      final response = await retry(
        () => http.get(Uri.parse(modifiedUrl), headers: updatedHeaders).timeout(
              const Duration(seconds: 15),
            ),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final parsed = parse(response);
          return parsed;
        } else {
          final parsed = parse('Success');
          return parsed;
        }
      } else if (response.statusCode == 401) {
        inspect(callDetails);
        throw Errors.unAuthorizedAccess;
      } else if (response.statusCode == 500) {
        inspect(callDetails);
        throw Errors.generalServerError;
      } else {
        inspect(callDetails);
        throw HttpException(parserServerError(response));
      }
    } catch (error) {
      inspect(callDetails);
      inspect(error);
      rethrow;
    }
  }

  static Future<dynamic> basePostCall(
      String url,
      Map<String, String> headers,
      Map<String, String> queryStrings,
      Map<String, dynamic> body,
      dynamic Function(dynamic) parse,
      [String stringbody = ""]) async {
    var updatedBody = body;

    var updatedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };
    headers.isNotEmpty ? updatedHeaders.addAll(headers) : 1;
    var modifiedUrl = addHeaderstoUrl(url, queryStrings);
    String encodedBody = json.encode(updatedBody);

    var callDetails = CallDetails(
        url: modifiedUrl,
        queryStrings: queryStrings,
        headers: updatedHeaders,
        body: updatedBody);

    if (stringbody != "") {
      encodedBody = stringbody;
    }
    try {
      final response = await retry(
        () => http
            .post(Uri.parse(modifiedUrl),
                body: encodedBody, headers: updatedHeaders)
            .timeout(
              const Duration(seconds: 15),
            ),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );

      ///  final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final parsed = parse(response);
        return parsed;
      } else if (response.statusCode == 401) {
        inspect(callDetails);
        throw Errors.unAuthorizedAccess;
      } else if (response.statusCode == 500) {
        inspect(callDetails);
        throw Errors.generalServerError;
      } else {
        inspect(callDetails);
        throw HttpException(parserServerError(response));
      }
    } catch (error) {
      inspect(callDetails);
      inspect(error);
      rethrow;
    }
  }
}

class Errors {
  static Exception reachedPagingEnd = const HttpException("reachedEndOfPages");
  static Exception unAuthorizedAccess =
      const HttpException("unAuthorizedAccess");
  static Exception generalServerError =
      const HttpException("An unexpected error has occurred");
}

String parserServerError(dynamic serverResponse) {
  // parser server error message here
  var errorResponse = json.decode(serverResponse.body);
  return errorResponse['Message'];
}

String addHeaderstoUrl(String url, Map<String, dynamic> headers) {
  var resultUrl = url;
  if (headers.isEmpty) {
    return url;
  }

  if (headers.length == 1) {
    var modifiedUrl =
        url + "?" + headers.keys.first + "=" + headers.values.first;
    return modifiedUrl;
  }

  var addedFirstElement = false;
  for (MapEntry e in headers.entries) {
    if (addedFirstElement == false) {
      resultUrl += "?" + "${e.key}" + "=" + "${e.value}";
      addedFirstElement = true;
      continue;
    }
    resultUrl += "&" + "${e.key}" + "=" + "${e.value}";
  }
  resultUrl = resultUrl.replaceAll(" ", "%20");
  return resultUrl;
}

/**
 sample post call
  Future<bool> changeProduct(String product, String speed, String customerId,
      String paymentTerms) async {
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);
    String changeProductUrl = Urls.changeProcudt;
    var queryStrings = {
      "Product": product,
      "UToken": accessToken,
      "CustomerID": customerId,
      "Speed": speed,
      "PaymentTerms": paymentTerms,
    };

    try {
      bool response = await _baseCalls
          .basePostCall(changeProductUrl, {}, queryStrings, null, (response) {
        return true;
      });
      return response;
    } catch (error) {
      inspect(error);
      throw (error);
    }
  }




  sample get call
  Future getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "OAuth2 " + accessToken
    };
    final url = Urls.userInfo;
    Map<String, String> queryStrings = {
      'UToken': accessToken,
      'Lang': 'En',
    };

    try {
      UserModel parsedResponse =
          await _baseCalls.baseGetCall(url, queryStrings, headers, (response) {
        var responseBody = json.decode(response.body);
        _user = UserModel.fromjson(responseBody["User"]);

        notifyListeners();
      });
      return parsedResponse;
    } catch (error) {
      inspect(error);
      throw (error);
    }
  }
 */
