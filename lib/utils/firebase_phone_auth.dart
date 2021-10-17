import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResend,
  Verified,
  Failed,
  Error,
  AutoRetrivalTimeOut,
  FlagsUpdated
}

class FirebasePhoneVerification {
  static var _authCredential, phone, actualCode, status;
  static StreamController<String> statusStream = StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState =
      StreamController.broadcast();
  static Stream stateStream = phoneAuthState.stream;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static BuildContext? ctx;
  static Future instanitiate(
      {required String phoneNumber, BuildContext? context}) async {
    phone = phoneNumber;
    ctx = context;
    print(phoneNumber);
    startAuth();
  }

  static startAuth() {
    statusStream.stream.listen((event) => print("phoneAuth: " + event));
    addStatus('Phone auth started');
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  static phoneCodeAutoRetrievalTimeout(String verificationId) {
    actualCode = verificationId;
    addStatus("\nAuto retrieval time out");
    addState(PhoneAuthState.AutoRetrivalTimeOut);
  }

  static phoneVerificationCompleted(AuthCredential credential) {
    addStatus('Auto retrieving verification code');
    _auth.signInWithCredential(credential).then((UserCredential result) {
      if (result.user != null) {
        addStatus(status = 'Authentication Successfully');
        addState(PhoneAuthState.Verified);
        onAuthenticationSuccessful(ctx!);
      }
    });
  }

  static void addStatus(String s) {
    statusStream.sink.add(s);
  }

  static void addState(PhoneAuthState state) {
    phoneAuthState.sink.add(state);
  }

  static void onAuthenticationSuccessful(BuildContext contex) async {
    try {
      await verify(phone);
      addState(PhoneAuthState.FlagsUpdated);
      addStatus('Flag updated');
    } on HttpException catch (_) {
      addState(PhoneAuthState.Error);
    } on SocketException catch (_) {
      addState(PhoneAuthState.Error);
    } catch (error) {
      addState(PhoneAuthState.Error);
      print(error);
      throw error;
    }
  }

  static Future<void> verify(String phoneNumber) async {
    /* String url = Urls.user_verify;
    Map<String, dynamic> verificationData = new Map<String, dynamic>();
    verificationData['country_code'] = countryCode;
    verificationData['mobile'] = phoneNumber;
    try {
      final response = await retry(
          () => http
              .post(Uri.parse(url), body: verificationData)
              .timeout(Duration(seconds: 5)),
          retryIf: (e) => e is SocketException || e is TimeoutException);
      final responseData = json.decode(response.body);
      print('respone data is: ' + responseData.toString());
      if (response.statusCode == 200) {
        _isAccountVerified = true;
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool(Constant.prefsUserIsVerifiedKey, true);
        notifyListeners();
      } else {
        throw HttpException(responseData['details']);
      }
    } catch (error) {
      print(error);
      throw error;
    }*/
  }

  static phoneVerificationFailed(FirebaseAuthException authException) {
    addStatus('${authException.message}');
    addState(PhoneAuthState.Error);
    if (authException.message != null) {
      if (authException.message!.contains('not authorized')) {
        addStatus('App not authroized');
      } else if (authException.message!.contains('Network')) {
        addStatus('Please check your internet connection and try again');
      } else {
        addStatus('Something has gone wrong, please try later ' +
            authException.message!);
      }
    }
  }

  static phoneCodeSent(String verificationId,
      [int? forceResendingToken]) async {
    actualCode = verificationId;
    addStatus("\nEnter the code sent to " + phone);
    addState(PhoneAuthState.CodeSent);
  }

  static Future<void> signInWithPhoneNumber(
      {String? smsCode, BuildContext? context}) async {
    _authCredential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode!);

    _auth
        .signInWithCredential(_authCredential)
        .then((UserCredential result) async {
      addStatus('Authentication successful');
      addState(PhoneAuthState.Verified);
      onAuthenticationSuccessful(context!);
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
  }
}
