import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/providers/ratings_provider.dart';
import 'package:i_padeel/providers/reservations_provider.dart';
import 'package:i_padeel/providers/user_provider.dart';
import 'package:i_padeel/screens/login&signup/signup_screen.dart';
import 'package:i_padeel/screens/main_screen.dart';
import 'package:i_padeel/screens/profile/profile_screen.dart';
import 'package:i_padeel/screens/bookings/reservations_list_screen.dart';
import 'package:i_padeel/providers/locations_provider.dart';
import 'package:i_padeel/providers/avaliable_slots_provider.dart';
import 'package:i_padeel/screens/splash_screen.dart';
import 'package:i_padeel/screens/tournaments/tournaments_screen.dart';
import 'package:i_padeel/screens/trainings/trainings_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
            create: (ctx) => UserProvider(null),
            update: (context, auth, previous) => previous!..updates(auth)),
        ChangeNotifierProvider.value(value: ReservationsProvider()),
        ChangeNotifierProvider.value(value: LocationsProvider()),
        ChangeNotifierProvider.value(value: AvaliableTimeSLotsProvider()),
        ChangeNotifierProvider.value(value: RatingsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          secondaryHeaderColor: AppColors.secondaryColor,
          canvasColor: const Color(0xff7B1FA2), //gradientColor1
          cardColor: const Color(0xff4527A0), //gradientColor2
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.black,
              fontFamily: 'Helvetica Neue',
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const MainScreen(),
        routes: {
          ReservationsListScreen.routeName: (context) =>
              const ReservationsListScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          TrainingsScreen.routeName: (context) => const TrainingsScreen(),
          TournamentsScreen.routeName: (context) => const TournamentsScreen(),
        },
      ),
    );
  }
}
