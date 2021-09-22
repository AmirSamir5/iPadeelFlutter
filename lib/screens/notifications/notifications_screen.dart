import 'package:flutter/material.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Notifications',
        context: context,
        leading: Container(),
        body: Container(),
      ),
    );
  }
}
