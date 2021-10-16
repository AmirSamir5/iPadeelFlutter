import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/user.dart';
import 'package:i_padeel/network/refresh_token.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/providers/user_provider.dart';
import 'package:i_padeel/screens/home/home_screen.dart';
import 'package:i_padeel/screens/login&signup/login_screen.dart';
import 'package:i_padeel/screens/notifications/notifications_screen.dart';
import 'package:i_padeel/screens/settings/settings_screen.dart';
import 'package:i_padeel/screens/side-menu/widgets/list_tile_widget.dart';
import 'package:i_padeel/screens/side-menu/widgets/user-sideInfo.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

class SideMenuWidget extends StatefulWidget {
  final int index;
  const SideMenuWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _SideMenuWidgetState createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int _currentIndex = 0;
  Widget? childWidget;
  BuildContext? childContext;
  bool _isChangingStatus = false;
  bool isAuth = false;
  bool _isInit = true;

  @override
  void initState() {
    if (_isInit) {
      Future.delayed(Duration.zero, () async {
        bool isLoggedIn =
            await Provider.of<AuthProvider>(context, listen: false)
                .isLoggedIn();
        if (isLoggedIn) {
          var user = await Provider.of<UserProvider>(context, listen: false)
              .getUserData();
          if (user == null) await _getUserProfile();
        }
        checkCurrentIndex();
      });
    }
    _isInit = false;
    super.initState();
  }

  checkCurrentIndex() {
    setState(() {
      _currentIndex = widget.index;
      switch (_currentIndex) {
        case 4:
          childWidget = LoginScreen(
            returnContext: (context) {
              childContext = context;
              SlideDrawer.of(childContext!)?.close();
            },
            loginSuccess: () {
              loginOrRegisterSuccess();
            },
            registerSuccess: () {
              loginOrRegisterSuccess();
            },
          );
          return;
        default:
          childWidget = null;
          return;
      }
    });
  }

  Future<void> _getUserProfile() async {
    setState(() {
      _isChangingStatus = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false).getUserProfile();
    } on HttpException catch (error) {
      if (error.message == '401') {
        RefreshTokenHelper.refreshToken(
          context: context,
          successFunc: () {
            _getUserProfile();
          },
        );
      } else {
        ShowDialogHelper.showDialogPopup('Error!', error.message, context, () {
          Navigator.of(context).pop();
        });
      }
    } on SocketException catch (_) {
      ShowDialogHelper.showDialogPopup("Error",
          "Please check your internet connection and try again", context, () {
        Navigator.of(context).pop();
      });
    } catch (error) {
      ShowDialogHelper.showDialogPopup(
          "Error", "Sorry, an unexpected error has occurred.", context, () {
        Navigator.of(context).pop();
      });
    }
    setState(() {
      _isChangingStatus = false;
    });
  }

  void loginOrRegisterSuccess() async {
    await _getUserProfile();
    setState(() {
      _isChangingStatus = false;
      _currentIndex = 0;
      isAuth = true;
      childWidget = HomeScreen(
        returnContext: (context) {
          childContext = context;
          SlideDrawer.of(childContext!)?.close();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isChangingStatus
        ? const Center(
            child: CircularProgressIndicator(
            backgroundColor: AppColors.secondaryColor,
          ))
        : FutureBuilder<bool>(
            future:
                Provider.of<AuthProvider>(context, listen: false).isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  backgroundColor: AppColors.secondaryColor,
                ));
              }
              isAuth = snapshot.data ?? false;
              return SlideDrawer(
                curve: Curves.easeInOut,
                backgroundColor: Colors.black,
                headDrawer: isAuth
                    ? Consumer<UserProvider>(
                        builder: (context, userProvider, _) {
                        return userProvider.user != null
                            ? UserSideInfo(
                                user: userProvider.user!,
                              )
                            : Container(
                                padding: const EdgeInsets.only(right: 32),
                                child: Image.asset(
                                  'assets/images/logo-white.png',
                                ),
                              );
                      })
                    : Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: Image.asset(
                          'assets/images/logo-white.png',
                        ),
                      ),
                duration: const Duration(milliseconds: 200),
                reverseCurve: Curves.easeInOut,
                child: childWidget ??
                    HomeScreen(
                      returnContext: (context) {
                        childContext = context;
                        SlideDrawer.of(childContext!)?.close();
                      },
                    ),
                contentDrawer: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      ListTileWidget(
                        currentIndex: _currentIndex,
                        widgetIndex: 0,
                        title: 'Home',
                        icon: Icons.home,
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                            childWidget = HomeScreen(
                              returnContext: (context) {
                                childContext = context;
                                SlideDrawer.of(childContext!)?.close();
                              },
                            );
                          });
                        },
                      ),
                      ListTileWidget(
                        currentIndex: _currentIndex,
                        widgetIndex: 1,
                        title: 'Courts',
                        icon: Icons.sports,
                        onTap: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                      ),
                      ListTileWidget(
                        currentIndex: _currentIndex,
                        widgetIndex: 2,
                        title: 'Settings',
                        icon: Icons.settings,
                        onTap: () {
                          setState(() {
                            _currentIndex = 2;
                            childWidget = SettingsScreen(
                              returnContext: (context) {
                                childContext = context;
                                SlideDrawer.of(childContext!)?.close();
                              },
                            );
                          });
                        },
                      ),
                      ListTileWidget(
                        currentIndex: _currentIndex,
                        widgetIndex: 3,
                        title: 'Notifications',
                        icon: Icons.notifications,
                        onTap: () {
                          setState(() {
                            _currentIndex = 3;
                            childWidget = NotificationsScreen(
                              returnContext: (context) {
                                childContext = context;
                                SlideDrawer.of(childContext!)?.close();
                              },
                            );
                          });
                        },
                      ),
                      isAuth
                          ? ListTileWidget(
                              currentIndex: _currentIndex,
                              widgetIndex: 4,
                              title: 'Logout',
                              icon: Icons.logout,
                              onTap: () async {
                                setState(() {
                                  _isChangingStatus = true;
                                });
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .logoutUser(context);
                                Future.delayed(const Duration(seconds: 1));
                                setState(() {
                                  _isChangingStatus = false;
                                  _currentIndex = 0;
                                  SlideDrawer.of(childContext!)?.close();
                                });
                              },
                            )
                          : ListTileWidget(
                              currentIndex: _currentIndex,
                              widgetIndex: 4,
                              title: 'Login',
                              icon: Icons.person,
                              onTap: () async {
                                setState(() {
                                  _currentIndex = 4;
                                  childWidget = LoginScreen(
                                    returnContext: (context) {
                                      childContext = context;
                                      SlideDrawer.of(childContext!)?.close();
                                    },
                                    loginSuccess: () {
                                      loginOrRegisterSuccess();
                                    },
                                    registerSuccess: () {
                                      loginOrRegisterSuccess();
                                    },
                                  );
                                });
                              },
                            ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
