import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/bookings/reservations_auth_widget.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:provider/provider.dart';

class ReservationsListScreen extends StatefulWidget {
  static String routeName = '/Reservations_List';
  const ReservationsListScreen({Key? key}) : super(key: key);

  @override
  _ReservationsListScreenState createState() => _ReservationsListScreenState();
}

class _ReservationsListScreenState extends State<ReservationsListScreen>
    with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'My Bookings',
        context: context,
        body: Consumer<AuthProvider>(
          builder: (ctx, authProv, child) {
            return authProv.isAccountAuthenticated
                ? const ReservationsAuthenticatedWidget()
                : FutureBuilder(
                    future: authProv.checkAuthentication(),
                    builder: (ctx, authResult) =>
                        authResult.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: AppColors.secondaryColor),
                              )
                            : Center(
                                child: Text(
                                  'No Bookings Available',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                  );
          },
        ),
      ),
    );
  }
}
