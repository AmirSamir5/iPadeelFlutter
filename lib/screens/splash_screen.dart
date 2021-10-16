import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/network/refresh_token.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/side-menu/side_menu_widget.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      RefreshTokenHelper.refreshToken(
        context: context,
        successFunc: () {
          // setNotificationsToken();
        },
        timeoutFunc: () {
          setState(() {
            ShowDialogHelper.showDialogPopup(
                'Error',
                'Something went wrong, Please Try Restarting the app!',
                context, () {
              Navigator.of(context).pop();
            });
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
              return Scaffold(
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                    ),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.black38,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Flexible(
                              flex: 4,
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.all(16),
                                  child: Image.asset(
                                    'assets/images/logo-white.png',
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Center(
                                child: Column(
                                  children: [
                                    const FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'Discover People',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Ubuntu',
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 64, vertical: 16),
                                        child: const Text(
                                          'Browse through enthusiasts and find the right matches for you',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Ubuntu',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Center(
                                child: Column(
                                  children: [
                                    isAuth
                                        ? Container()
                                        : Column(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SideMenuWidget(
                                                      index: 4,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      'Already Member ?  ',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      'SIGN IN',
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: Colors.white,
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    const SizedBox(height: 8),
                                    CustomTextButton(
                                      text: 'Skip',
                                      onPressed: () =>
                                          Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SideMenuWidget(
                                            index: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
  }
}
