import 'package:flutter/material.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';

class OnlineShopScreen extends StatefulWidget {
  const OnlineShopScreen({Key? key}) : super(key: key);

  @override
  _OnlineShopScreenState createState() => _OnlineShopScreenState();
}

class _OnlineShopScreenState extends State<OnlineShopScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Online Shop',
        context: context,
        leading: Container(),
        body: Container(),
      ),
    );
  }
}
