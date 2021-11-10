// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/firebase_phone_auth.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';

class VerificationScreen extends StatefulWidget {
  String _mobileNumber;
  final _formKey = GlobalKey<FormState>();
  final Function? _onSuccess;
  VerificationScreen({required String mobileNumber, Function? onSuccess})
      : _mobileNumber = mobileNumber,
        _onSuccess = onSuccess;
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _codeEntered = '';
  var _isLoading = false;
  var _isInit = true;

  FocusNode verificationCodeFocusNode = FocusNode();

  _showDialog(String title, String message, Function ok) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          elevation: 15,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ok();
                widget._onSuccess != null ? widget._onSuccess!() : 1;
                _isLoading = false;
              },
            )
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(String message) {
    ShowDialogHelper.showSuccessMessage(message, context);
    setState(() {
      _isLoading = false;
    });
  }

  void _removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  _saveForm() async {
    var state = widget._formKey.currentState;
    if (state == null) {
      return;
    }
    final _isValid = state.validate();
    _removeFocus();
    if (_isValid) {
      state.save();

      await _signIn();
    }
  }

  _signIn() async {
    setState(() {
      _isLoading = true;
    });
    FirebasePhoneVerification.signInWithPhoneNumber(
        smsCode: _codeEntered, context: context);
  }

  Future<void> _startPhoneAuth(String mobile) async {
    await FirebasePhoneVerification.instanitiate(
        phoneNumber: "+2" + mobile, context: context);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      verificationCodeFocusNode = FocusNode();
      _startPhoneAuth(widget._mobileNumber);
      FirebasePhoneVerification.phoneAuthState = StreamController.broadcast();
      FirebasePhoneVerification.phoneAuthState.stream
          .listen((PhoneAuthState state) {
        setState(() {
          _isLoading = false;
        });
        print('state is: $state');

        if (state == PhoneAuthState.AutoRetrivalTimeOut) {
          _showDialog("Failed", "Request timed out", () {});
        }
        if (state == PhoneAuthState.CodeSent) {
          _showSuccessDialog('Code Sent Successfully!');
        }
        if (state == PhoneAuthState.Verified) {
          setState(() {
            _isLoading = false;
          });
        } else if (state == PhoneAuthState.FlagsUpdated) {
          setState(() {
            _isLoading = false;
          });
          _showDialog("Success", "Your mobile number is verified successfully",
              () {
            Navigator.of(context).pop();
          });
          print('Success');
        } else if (state == PhoneAuthState.Failed) {
          _showDialog("Failed", "Invalid code", () {});
          print('Invalid code');
        } else if (state == PhoneAuthState.Error) {
          _showDialog(
              'Failed', 'Sorry, an unexpected error has occurred.', () {});
          print('somethine went error');
        }
      });
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    verificationCodeFocusNode.dispose();
    FirebasePhoneVerification.phoneAuthState.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text('Verify Mobile Number'),
      ),
      Container(
        color: AppColors.primaryColor,
        width: double.infinity,
        margin:
            const EdgeInsets.only(top: 100, bottom: 20, left: 20, right: 20),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Card(
                  color: AppColors.primaryColor.withAlpha(100),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'A verification code SMS is sent to ',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          FirebasePhoneVerification.phone,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                            'Please enter that code to verify your mobile number',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Form(
                    key: widget._formKey,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Please enter your verification code...',
                        hintStyle: TextStyle(color: Colors.white24),
                        labelText: 'Verification Code',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      keyboardType: TextInputType.number,
                      keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.white,
                      maxLength: 6,
                      /*validator: (value) {
                            if (value.length != 6) {
                              return ('Please enter a valid code');
                            }
                            return null;
                          },*/
                      onSaved: (value) {
                        _codeEntered = value ?? "";
                      },
                    )),
              ),
              const SizedBox(
                height: 24,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : CustomTextButton(
                      text: 'Verify',
                      onPressed: () => _saveForm(),
                    ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text('Maybe later',
                        style: Theme.of(context).textTheme.headline2),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
