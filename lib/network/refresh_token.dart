import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefreshTokenHelper {
  static Future<void> refreshToken({
    BuildContext? context,
    Function? successFunc,
    Function? timeoutFunc,
  }) async {
    try {
      await Provider.of<AuthProvider>(context!, listen: false).refreshToken();
      if (successFunc == null) return;
      successFunc();
    } on SocketException catch (_) {
      /*ShowDialogHelper.showDialogPopup("Connectivity issue",
          "Please check your internet connection and try again", context, () {
        Navigator.of(context).pop();
        timeoutFunc();
      });*/
      if (timeoutFunc == null) return;
      timeoutFunc();
    } on TimeoutException catch (_) {
      /*ShowDialogHelper.showDialogPopup("Connectivity issue",
          "Please check your internet connection and try again", context, () {
        Navigator.of(context).pop();
        timeoutFunc();
      });*/
      if (timeoutFunc == null) return;
      timeoutFunc();
    } on HttpException catch (_) {
      try {
        final prefs = await SharedPreferences.getInstance();
        String? username = prefs.getString(Constant.prefsUsername);
        String? password = prefs.getString(Constant.prefsPassword);
        if (username != null &&
            username != "" &&
            password != null &&
            password != "") {
          await Provider.of<AuthProvider>(context!).login(username, password);
        }
        if (successFunc == null) return;
        successFunc();
      } catch (error) {
        await Provider.of<AuthProvider>(context!).logoutUser(context);
        /*ShowDialogHelper.showDialogPopup(
            "Sorry, an unexpected error has occurred.", "Please try again later", context, () {
          Navigator.of(context).pop();
          timeoutFunc();
        });*/
        if (timeoutFunc == null) return;
        timeoutFunc();
      }
    } catch (error) {
      try {
        final prefs = await SharedPreferences.getInstance();
        String? username = prefs.getString(Constant.prefsUsername);
        String? password = prefs.getString(Constant.prefsPassword);

        await Provider.of<AuthProvider>(context!).login(username!, password!);
        if (successFunc == null) return;
        successFunc();
      } catch (error) {
        await Provider.of<AuthProvider>(context!).logoutUser(context);
        /*ShowDialogHelper.showDialogPopup(
            "Sorry, an unexpected error has occurred.", "Please try again later", context, () {
          Navigator.of(context).pop();
          timeoutFunc();
        });*/
        if (timeoutFunc == null) return;
        timeoutFunc();
      }
    }
  }
}
