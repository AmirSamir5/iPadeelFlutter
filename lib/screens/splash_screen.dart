import 'package:flutter/material.dart';
import 'package:i_padeel/widgets/custom_bottom_navigationbar.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/logo.jpeg',
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Discover People',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 64, vertical: 16),
                      child: const Text(
                        'Browse through enthusiasts and find the right matches for you',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
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
                          builder: (context) => const CustomBottomNavigationBar(
                            currentIndex: 2,
                          ),
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
                          builder: (context) => const CustomBottomNavigationBar(
                            currentIndex: 0,
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
    );
  }
}
