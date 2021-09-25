import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/widgets/custom_input_field.dart';
import 'package:i_padeel/widgets/custom_password_field.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool obsecureText = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        extendbody: true,
        scaffoldKey: _scaffoldkey,
        appBarTitle: '',
        context: context,
        leading: Container(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 40,
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
                      child: Column(
                        children: [
                          CustomTextInputField(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            controller: _emailController,
                            prefixIcon: const Icon(
                              Icons.email,
                              color: AppColors.hintTextColor,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          PasswordInput(
                            passwordController: _passwordController,
                            obscureText: obsecureText,
                            callback: () {
                              setState(() {
                                obsecureText = !obsecureText;
                              });
                            },
                          )
                        ],
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
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const CustomBottomNavigationBar(
                          //       currentIndex: 2,
                          //     ),
                          //   ),
                          // ),
                          onTap: () {},
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
                        CustomTextButton(
                          text: 'Login',
                          onPressed: () {},
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
