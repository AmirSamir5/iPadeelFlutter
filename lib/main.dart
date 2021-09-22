import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/screens/splash_screen.dart';
import 'package:i_padeel/widgets/custom_bottom_navigationbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.secondaryColor,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontFamily: 'Ubuntu',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.black,
            fontFamily: 'Helvetica Neue',
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
