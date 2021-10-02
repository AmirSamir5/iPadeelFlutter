import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/reservation.dart';
import 'package:i_padeel/network/refresh_token.dart';
import 'package:i_padeel/providers/reservations_provider.dart';
import 'package:i_padeel/screens/reservationsList/reservation_cell.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:provider/provider.dart';

class ReservationsAuthenticatedWidget extends StatefulWidget {
  const ReservationsAuthenticatedWidget({Key? key}) : super(key: key);

  @override
  _ReservationsAuthenticatedWidgetState createState() =>
      _ReservationsAuthenticatedWidgetState();
}

class _ReservationsAuthenticatedWidgetState
    extends State<ReservationsAuthenticatedWidget> {
  bool _isInit = true;
  bool _isLoading = true;
  List<Reservation> _reservationsList = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _loadReservations();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _loadReservations() async {
    try {
      await Provider.of<ReservationsProvider>(context, listen: false)
          .loadReservations();
      _reservationsList =
          Provider.of<ReservationsProvider>(context, listen: false)
              .reservationsList;
    } on HttpException catch (error) {
      if (error.message == '401') {
        RefreshTokenHelper.refreshToken(
          context: context,
          successFunc: () {
            _loadReservations();
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
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryColor,
              ),
            )
          : _reservationsList.isEmpty
              ? Center(
                  child: Text(
                    'No Reservations Available',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) {
                    return ReservationsCell(
                      _reservationsList[index],
                      index,
                    );
                  },
                  itemCount: _reservationsList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
    );
  }
}
