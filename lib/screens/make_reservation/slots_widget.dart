import 'package:flutter/material.dart';

class SlotsWidget extends StatelessWidget {
  String fromTime;
  String toTime;
  int seats;

  SlotsWidget(
      {required this.fromTime, required this.toTime, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            fromTime,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            toTime,
            style: TextStyle(color: Colors.black, fontSize: 12),
          )
        ],
      ),
    );
  }
}
