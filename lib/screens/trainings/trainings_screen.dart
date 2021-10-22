import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';

class TrainingsScreen extends StatefulWidget {
  static const routeName = '/Trainings_Screen';
  const TrainingsScreen({Key? key}) : super(key: key);

  @override
  _TrainingsScreenState createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Trainings',
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
