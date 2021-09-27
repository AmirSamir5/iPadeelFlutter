import 'package:flutter/material.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:slide_drawer/slide_drawer.dart';

class NotificationsScreen extends StatefulWidget {
  final Function(BuildContext)? returnContext;
  const NotificationsScreen({Key? key, this.returnContext}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with PageHelper {
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
        appBarTitle: 'Notifications',
        context: context,
        leading: IconButton(
          onPressed: () => SlideDrawer.of(context)?.toggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body: Container(),
      ),
    );
  }
}
