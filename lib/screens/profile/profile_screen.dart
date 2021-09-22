import 'package:flutter/material.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Profile',
        context: context,
        leading: Container(),
        body: Container(),
      ),
    );
  }
}
