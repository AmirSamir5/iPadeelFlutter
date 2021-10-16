import 'package:flutter/material.dart';

class CustomGenderWidget extends StatefulWidget {
  final String? oldGenederSelected;
  final Function(String) selectedGender;

  const CustomGenderWidget(
      {Key? key, this.oldGenederSelected, required this.selectedGender})
      : super(key: key);

  @override
  _CustomGenderWidgetState createState() => _CustomGenderWidgetState();
}

class _CustomGenderWidgetState extends State<CustomGenderWidget> {
  String? selectedRadioTile;

  @override
  void initState() {
    selectedRadioTile = widget.oldGenederSelected;
    super.initState();
  }

  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
      widget.selectedGender(selectedRadioTile!.toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto-Medium',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Row(children: <Widget>[
          Expanded(
            child: RadioListTile(
              value: 'Male',
              activeColor: Colors.white,
              groupValue: selectedRadioTile,
              onChanged: (val) {
                setSelectedRadioTile(val as String);
              },
              title: const Text(
                'Male',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: RadioListTile(
              value: 'Female',
              activeColor: Colors.white,
              groupValue: selectedRadioTile,
              onChanged: (val) {
                setSelectedRadioTile(val as String);
              },
              title: const Text(
                'Female',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
