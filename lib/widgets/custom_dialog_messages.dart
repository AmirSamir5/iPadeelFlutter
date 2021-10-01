import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowDialogHelper {
  static void showDialogPopup(
      String title, String message, BuildContext context, Function okFunc) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                'Ok',
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

  static void showDialogPopupWithCancel(String title, String message,
      BuildContext context, Function cancelFunc, Function okFunc) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(
            title,
          ),
          content: Text(message,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Avenir',
                  color: Colors.black)),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                'Cancel',
              ),
              onPressed: () {
                cancelFunc();
              },
            ),
            ElevatedButton(
              child: const Text(
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
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.BOTTOM,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[500],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
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
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.BOTTOM,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green[900],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: Image.asset(
                'assets/icon/check.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
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
