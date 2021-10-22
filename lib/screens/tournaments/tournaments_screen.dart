import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';

class TournamentsScreen extends StatefulWidget {
  static const routeName = '/Tournaments_Screen';
  const TournamentsScreen({Key? key}) : super(key: key);

  @override
  _TournamentsScreenState createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Tournaments',
        context: context,
        extendbody: true,
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
