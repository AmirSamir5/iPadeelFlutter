import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/user.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:path_provider/path_provider.dart';
import 'package:i_padeel/screens/login&signup/rating_screen.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_bottom_sheet.dart';
import 'package:i_padeel/widgets/custom_date_picker.dart';
import 'package:i_padeel/widgets/custom_gender.dart';
import 'package:i_padeel/widgets/custom_image_picker.dart';
import 'package:i_padeel/widgets/custom_input_field.dart';
import 'package:i_padeel/widgets/custom_password_field.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  final Function? registerSuccess;
  final User? user;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  RegistrationScreen({Key? key, this.registerSuccess, this.user})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with PageHelper {
  final GlobalKey<FormState> _formKey = GlobalKey();
  User user = User();
  String? _selectedDate;
  String? _selectedGender;
  File? _pickedImage;
  bool obsecureText = true;
  bool _isEdit = false;
  bool _isInit = true;
  bool _isImageLoading = false;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    if (_isInit) {
      if (widget.user != null) {
        _isEdit = true;
        user = widget.user!;
        _firstNameController = TextEditingController(text: user.firstName);
        _lastNameController = TextEditingController(text: user.lastName);
        _emailController = TextEditingController(text: user.email);
        _mobileController = TextEditingController(text: user.phone);
        _selectedDate = user.dateOfBirth;
        _selectedGender = widget.user!.gender;
        setOldImage();
      }
      _isInit = false;
    }
    super.initState();
  }

  setOldImage() async {
    if (user.photo == null) return;
    _pickedImage = await urlToFile(Urls.domain + user.photo!);
  }

  Future<File> urlToFile(String imageUrl) async {
    setState(() {
      _isImageLoading = true;
    });
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      _isImageLoading = false;
    });
    return file;
  }

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
      user.firstName = _firstNameController.text;
      user.lastName = _lastNameController.text;
      user.email = _emailController.text;
      user.password = _passwordController.text;
      user.dateOfBirth = _selectedDate;
      user.gender = _selectedGender;
      user.phone = _mobileController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RatingsScreen(
            user: user,
            registerSuccess: widget.registerSuccess,
            pickedImage: _pickedImage,
            isEdit: _isEdit,
          ),
        ),
      );
    }
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
        scaffoldKey: widget.scaffoldkey,
        extendbody: true,
        context: context,
        body: Container(
          color: AppColors.primaryColor,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: Text(
                      _isEdit ? 'Edit Profile' : 'Registration',
                      style: const TextStyle(
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
                        _isImageLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.secondaryColor,
                                ),
                              )
                            : CustomImagePicker(
                                oldPickedImage: _pickedImage,
                                pickedImage: (pickedImage) {
                                  _pickedImage = pickedImage;
                                },
                              ),
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
                        _isEdit
                            ? const SizedBox()
                            : CustomPasswordInput(
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
                          oldDate: _selectedDate,
                        ),
                        CustomGenderWidget(
                          oldGenederSelected: user.gender,
                          selectedGender: (selectedGender) {
                            _selectedGender = selectedGender;
                            _removeFocus();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextButton(
                    text: 'Next',
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
