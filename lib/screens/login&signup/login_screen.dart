import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/login&signup/signup_screen.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_input_field.dart';
import 'package:i_padeel/widgets/custom_password_field.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:validators/validators.dart' as validator;

class LoginScreen extends StatefulWidget {
  final Function(BuildContext)? returnContext;
  final Function? loginSuccess;
  final Function? registerSuccess;
  const LoginScreen(
      {Key? key, this.returnContext, this.loginSuccess, this.registerSuccess})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool obsecureText = true;
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void initState() {
    if (_isInit) {
      _isInit = false;
      widget.returnContext!(context);
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_emailController.text, _passwordController.text);
      widget.loginSuccess!();
    } on HttpException catch (error) {
      ShowDialogHelper.showDialogPopup(
          'Authentication Failed', error.message, context, () {
        Navigator.of(context).pop();
      });
    } on SocketException catch (_) {
      ShowDialogHelper.showDialogPopup(
          'Error',
          'please check your internet connection and try again later',
          context, () {
        Navigator.of(context).pop();
      });
    } catch (error) {
      ShowDialogHelper.showDialogPopup(
          'Authentication Failed', error.toString(), context, () {
        Navigator.of(context).pop();
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  _saveForm() {
    _removeFocus();
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      _loginUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        extendbody: true,
        scaffoldKey: _scaffoldkey,
        appBarTitle: '',
        context: context,
        leading: IconButton(
          onPressed: () => SlideDrawer.of(context)?.toggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Image.asset(
                        'assets/images/logo-white.png',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextInputField(
                              labelText: 'Email',
                              validateEmptyString: true,
                              hintText: 'Enter your email',
                              controller: _emailController,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: AppColors.hintTextColor,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomPasswordInput(
                              labelText: 'Password',
                              passwordController: _passwordController,
                              obscureText: obsecureText,
                              callback: () {
                                setState(() {
                                  obsecureText = !obsecureText;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(
                                  registerSuccess: widget.registerSuccess!),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Don't Have An Account ?  ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'Register Now!',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.secondaryColor,
                                ),
                              )
                            : CustomTextButton(
                                text: 'Login',
                                onPressed: () => _saveForm(),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
