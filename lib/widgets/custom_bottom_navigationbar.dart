import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/discover/discover_screen.dart';
import 'package:i_padeel/screens/login&signup/login_screen.dart';
import 'package:i_padeel/screens/online-shop.dart/online-shop-screen.dart';
import 'package:i_padeel/widgets/custom_auth_screen.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(BuildContext)? returnContext;
  const CustomBottomNavigationBar(
      {Key? key, required this.currentIndex, this.returnContext})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screensList = [
    const DiscoverScreen(),
    const OnlineShopScreen(),
    const CustomAuthScreen(),
  ];
  int _currentIndex = 0;
  bool _isInit = true;

  @override
  void initState() {
    if (_isInit) {
      // UserRepo.setBuildContext(context);
      _currentIndex = widget.currentIndex;
      _isInit = false;
      if (widget.returnContext == null) return;
      widget.returnContext!(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<AuthProvider>(context).isAccountAuthenticated;
    return Scaffold(
      key: _scaffoldKey,
      body: IndexedStack(
        children: _screensList,
        index: _currentIndex,
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              spreadRadius: 0.1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: AppColors.secondaryColor,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Online Shop',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: isAuth ? 'Profile' : 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
