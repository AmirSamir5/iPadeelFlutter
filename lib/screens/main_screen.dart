import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/network/refresh_token.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/side-menu/side_menu_widget.dart';
import 'package:i_padeel/screens/splash_screen.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // FirebaseMessagingHelper.configure(context);
      checkUserIsLoggedIn();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future checkUserIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);
    if (accessToken != null && accessToken.isNotEmpty) {
      Provider.of<AuthProvider>(context, listen: false)
          .setBuildContext(context);
      await RefreshTokenHelper.refreshToken(
        context: context,
        successFunc: () {
          // setNotificationsToken();
        },
        timeoutFunc: () {
          ShowDialogHelper.showDialogPopup(
              'Error',
              'Something went wrong, Please Try Restarting the app!',
              context, () {
            Navigator.of(context).pop();
          });
        },
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Future setNotificationsToken() async {
  //   try {
  //     await FirebaseMessagingHelper.getToken();
  //     await Provider.of<AuthProvider>(context, listen: false)
  //         .setPushNotificationsToken();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } on HttpException catch (error) {
  //     if (error.message == '401') {
  //       RefreshTokenHelper.refreshToken(
  //         context: context,
  //         successFunc: () {
  //           setNotificationsToken();
  //         },
  //         timeoutFunc: () {
  //           setState(() {
  //             _showDialog(
  //                 'Something went wrong, Please Try Restarting the app!');
  //           });
  //         },
  //       );
  //     }
  //   } on SocketException catch (_) {
  //     _showDialog('Please check Internet Connection');
  //   } catch (error) {
  //     // _showDialog('Something went wrong with notifications token');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.secondaryColor,
            ),
          )
        : FutureBuilder<bool>(
            future: Provider.of<AuthProvider>(context).isLoggedIn(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  backgroundColor: AppColors.secondaryColor,
                ));
              }
              bool isAuth = snapshot.data ?? false;
              return isAuth
                  ? const SideMenuWidget(index: 0)
                  : const SplashScreen();
            },
          );
  }
}
