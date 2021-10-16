import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/login&signup/login_screen.dart';
import 'package:i_padeel/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class CustomAuthScreen extends StatefulWidget {
  const CustomAuthScreen({Key? key}) : super(key: key);
  @override
  _CustomAuthScreenState createState() => _CustomAuthScreenState();
}

class _CustomAuthScreenState extends State<CustomAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, auth, _) {
      return (auth.isAccountAuthenticated)
          ? const ProfileScreen()
          : FutureBuilder(
              future: auth.checkAuthentication(),
              builder: (ctx, authResult) =>
                  authResult.connectionState == ConnectionState.waiting
                      ? const CircularProgressIndicator(
                          backgroundColor: AppColors.secondaryColor)
                      : LoginScreen(),
            );
    });
  }
}
