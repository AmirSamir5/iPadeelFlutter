import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
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
        extendbody: true,
        leading: Container(),
        body: Container(
          color: AppColors.primaryColor,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/coming-soon.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
