import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xff022946);
  static const Color secondaryColor = Color(0xffE2FB52);
  static const Color hintTextColor = Color(0xff400935);
  static Color backGroundColorLight = parseColor("0B2441");
  static Color backGroundColor = parseColor("02060B");

}

Color parseColor(String color) {
  String hex = color.replaceAll("#", "");
  if (hex.isEmpty) hex = "ffffff";
  if (hex.length == 3) {
    hex =
        '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
  }
  Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  return col;
}
