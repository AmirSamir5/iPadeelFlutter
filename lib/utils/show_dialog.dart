import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:i_padeel/constants/app_colors.dart';

class ShowDialogHelper {
  static void showDialogPopup(
      String title, String message, BuildContext context, Function okFunc) {
    if (context != null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => WillPopScope(
          onWillPop: () async => false,
          child: new AlertDialog(
            backgroundColor: AppColors.backGroundColorLight,
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  okFunc();
                },
              )
            ],
          ),
        ),
      );
    }
  }

  static void showDialogPopupWithCancel(String title, String message,
      BuildContext context, Function cancelFunc, Function okFunc) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false,
        child: new AlertDialog(
          title: Text(
            title,
          ),
          content: Text(message,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Avenir',
                  color: Colors.black)),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
                cancelFunc();
              },
            ),
            FlatButton(
              child: Text(
                'OK',
              ),
              onPressed: () {
                okFunc();
              },
            ),
          ],
        ),
      ),
    );
  }

  static void showErrorMessage(String message, BuildContext context) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.BOTTOM,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[500],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Avenir',
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 8.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static void showSuccessMessage(String message, BuildContext context) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.BOTTOM,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green[900],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 28,
              width: 28,
              child: Image.asset(
                "assets/images/check.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Avenir',
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 8.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
