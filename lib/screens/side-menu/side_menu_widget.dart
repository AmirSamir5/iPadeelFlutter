import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/notifications/notifications_screen.dart';
import 'package:i_padeel/screens/profile/profile_screen.dart';
import 'package:i_padeel/screens/settings/settings_screen.dart';
import 'package:i_padeel/screens/side-menu/widgets/list_tile_widget.dart';
import 'package:i_padeel/screens/side-menu/widgets/user-sideInfo.dart';
import 'package:i_padeel/widgets/custom_bottom_navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

class SideMenuWidget extends StatefulWidget {
  final int currentIndex;
  const SideMenuWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _SideMenuWidgetState createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int _currentIndex = 0;
  Widget? childWidget;
  BuildContext? childContext;

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<AuthProvider>(context).isAccountAuthenticated;
    return SlideDrawer(
      curve: Curves.easeInOut,
      backgroundColor: Colors.black,
      headDrawer: const UserSideInfo(),
      duration: const Duration(milliseconds: 200),
      reverseCurve: Curves.easeInOut,
      child: childWidget ??
          CustomBottomNavigationBar(
            currentIndex: widget.currentIndex,
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
                  childWidget = CustomBottomNavigationBar(
                    currentIndex: 0,
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
                      await Provider.of<AuthProvider>(context, listen: false)
                          .logoutUser(context);
                      setState(() {
                        _currentIndex = 0;
                        SlideDrawer.of(childContext!)?.close();
                      });
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
