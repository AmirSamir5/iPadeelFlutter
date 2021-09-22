import 'package:flutter/material.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Login',
        context: context,
        leading: Container(),
        body: Container(),
      ),
    );
  }
}
