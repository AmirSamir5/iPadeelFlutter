import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/widgets/custom_date_picker.dart';
import 'package:i_padeel/widgets/custom_gender.dart';
import 'package:i_padeel/widgets/custom_image_picker.dart';
import 'package:i_padeel/widgets/custom_input_field.dart';
import 'package:i_padeel/widgets/custom_password_field.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = '/Registartion_Screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _selectedDate;
  String? _selectedGender;
  File? _pickedImage;
  bool obsecureText = true;
  bool _isLoading = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _occupationController.dispose();
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
      _registerUser();
    }
  }

  Future _registerUser() async {}

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
                          labelText: 'Occupation',
                          showLabelText: true,
                          validateEmptyString: true,
                          hintText: 'Enter your occupation',
                          controller: _occupationController,
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
                          },
                        ),
                        CustomGenderWidget(
                          selectedGender: (selectedGender) {
                            _selectedGender = selectedGender;
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
