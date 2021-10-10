import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/user.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_date_picker.dart';
import 'package:i_padeel/widgets/custom_gender.dart';
import 'package:i_padeel/widgets/custom_image_picker.dart';
import 'package:i_padeel/widgets/custom_input_field.dart';
import 'package:i_padeel/widgets/custom_password_field.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  final Function? registerSuccess;
  const RegistrationScreen({Key? key, required this.registerSuccess})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  User user = User();
  String? _selectedDate;
  String? _selectedGender;
  File? _pickedImage;
  bool obsecureText = true;
  bool _isLoading = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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

  _saveForm() {
    _removeFocus();
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ShowDialogHelper.showDialogPopup(
          'Warning',
          'Please Select Date!',
          context,
          _hideDialog,
        );
        return;
      } else if (_selectedGender == null) {
        ShowDialogHelper.showDialogPopup(
          'Warning',
          'Please Select Gender!',
          context,
          _hideDialog,
        );
        return;
      }
      _registerUser();
    }
  }

  Future _registerUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      user.firstName = _firstNameController.text;
      user.lastName = _lastNameController.text;
      user.email = _emailController.text;
      user.password = _passwordController.text;
      user.dateOfBirth = _selectedDate;
      user.gender = _selectedGender;
      user.phone = _mobileController.text;
      await Provider.of<AuthProvider>(context, listen: false)
          .registerUser(user, _pickedImage);
      Navigator.of(context).popUntil((route) => route.isFirst);
      widget.registerSuccess!();
    } on HttpException catch (error) {
      ShowDialogHelper.showDialogPopup('Error', error.message, context, () {
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

  _hideDialog() {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        extendbody: true,
        context: context,
        body: Container(
          color: AppColors.primaryColor,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: const Text(
                      'Registration',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomImagePicker(pickedImage: (pickedImage) {
                          _pickedImage = pickedImage;
                        }),
                        CustomTextInputField(
                          labelText: 'First Name',
                          showLabelText: true,
                          validateEmptyString: true,
                          hintText: 'Enter your first Name',
                          controller: _firstNameController,
                        ),
                        CustomTextInputField(
                          labelText: 'Last Name',
                          showLabelText: true,
                          validateEmptyString: true,
                          hintText: 'Enter your last name',
                          controller: _lastNameController,
                        ),
                        CustomTextInputField(
                          labelText: 'Email',
                          showLabelText: true,
                          validateEmptyString: true,
                          hintText: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextInputField(
                          labelText: 'Mobile',
                          showLabelText: true,
                          validateEmptyString: true,
                          hintText: 'Enter your mobile',
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                        ),
                        CustomPasswordInput(
                          labelText: 'Password',
                          showLabelText: true,
                          passwordController: _passwordController,
                          obscureText: obsecureText,
                          showPrefixIcon: false,
                          callback: () {
                            setState(() {
                              obsecureText = !obsecureText;
                            });
                          },
                        ),
                        CustomDatePickerWidget(
                          title: 'Date Of Birth',
                          selectedDate: (selectedDate) {
                            _selectedDate = selectedDate;
                            _removeFocus();
                          },
                        ),
                        CustomGenderWidget(
                          selectedGender: (selectedGender) {
                            _selectedGender = selectedGender;
                            _removeFocus();
                          },
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
                          text: 'Register',
                          onPressed: () => _saveForm(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
