import 'package:flutter/material.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:slide_drawer/slide_drawer.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/Profile_Screen';
  final Function(BuildContext)? returnContext;
  const ProfileScreen({Key? key, this.returnContext}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool _isInit = true;

  @override
  void initState() {
    if (_isInit) {
      _isInit = false;
      if (widget.returnContext == null) return;
      widget.returnContext!(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Profile',
        context: context,
        body: Container(),
      ),
    );
  }
}
