import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/screens/make_reservation/select_time_slot.dart';

class CreateReservationScreen extends StatefulWidget {
  CreateReservationScreen({Key? key}) : super(key: key);

  @override
  _CreateReservationScreenState createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
          AppColors.backGroundColorLight,
          AppColors.backGroundColor
        ])),
        child: Column(
          children: [
            SelectTimeSlotWidget(
              resId: '',
            )
          ],
        ),
      ),
    );
  }
}
