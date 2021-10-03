import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlotsWidget extends StatefulWidget {
  final String fromTime;
  final String toTime;

  SlotsWidget({
    required this.fromTime,
    required this.toTime,
  });

  final DateFormat formatter = DateFormat('hh-mm a');

  @override
  State<SlotsWidget> createState() => _SlotsWidgetState();
}

class _SlotsWidgetState extends State<SlotsWidget> {
  String fromFormattedTime() {
    return widget.formatter
        .format(DateFormat('HH/mm/ss').parse(widget.fromTime));
  }

  String toFormattedTime() {
    return widget.formatter.format(DateFormat('HH/mm/ss').parse(widget.toTime));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.fromTime,
          style: const TextStyle(color: Colors.black, fontSize: 12),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.toTime,
          style: const TextStyle(color: Colors.black, fontSize: 12),
        )
      ],
    );
  }
}
