import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/screens/create_reservation/select_time_slot.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';

class CreateReservationScreen extends StatefulWidget {
  CreateReservationScreen({Key? key}) : super(key: key);

  @override
  _CreateReservationScreenState createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen>
    with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Create Reservation',
        context: context,
        body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
            AppColors.backGroundColorLight,
            AppColors.backGroundColor
          ])),
          child: SelectTimeSlotWidget(
            resId: '',
          ),
        ),
      ),
    );
  }
}
