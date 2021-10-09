import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:intl/intl.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final String title;
  final Function(String) selectedDate;

  const CustomDatePickerWidget({
    Key? key,
    required this.title,
    required this.selectedDate,
  }) : super(key: key);
  @override
  _CustomDatePickerWidgetState createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  String? _formatted;

  Future _selectDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        currentTime: DateTime(1990, 1),
        minTime: DateTime(1970, 1),
        maxTime: DateTime.now());
    final DateFormat formater = DateFormat('yyyy-MM-dd');

    if (pickedDate == null) {
      return;
    } else {
      setState(() {
        _formatted = formater.format(pickedDate);
        widget.selectedDate(_formatted!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto-Medium',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: InkWell(
              onTap: () {
                _selectDateOfBirth(context);
              },
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.date_range,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatted ?? 'No Date Choosen!',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontFamily: 'Roboto-Medium',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
