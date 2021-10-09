import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:i_padeel/screens/side-menu/side_menu_widget.dart';
import 'package:i_padeel/widgets/custom_bottom_navigationbar.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/3.jpg',
            fit: BoxFit.fill,
          ),
          Container(
            color: Colors.black45,
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
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SideMenuWidget(),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Already Member ?  ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Ubuntu',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontFamily: 'Ubuntu',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextButton(
                            text: 'Skip',
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SideMenuWidget(),
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
  }
}
