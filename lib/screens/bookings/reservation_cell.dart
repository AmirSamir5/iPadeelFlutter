import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'dart:ui' as ui;

import 'package:i_padeel/models/reservation.dart';
import 'package:i_padeel/network/refresh_token.dart';
import 'package:i_padeel/providers/reservations_provider.dart';
import 'package:i_padeel/screens/bookings/reservation_cell_bottom.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

class ReservationsCell extends StatelessWidget {
  final Reservation reservation;
  final int index;

  const ReservationsCell(this.reservation, this.index, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 400,
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: SizedBox(
                  height: 300,
                  child: OptimizedCacheImage(
                    fit: BoxFit.cover,
                    imageUrl: Urls.domain +
                        (reservation.location.image ??
                            "https://images.unsplash.com/photo-1499510318569-1a3d67dc3976?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=928&q=80"),
                    placeholder: (context, url) => LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black.withOpacity(0.2)),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            ReservationBottomWidget(reservation, index),
          ],
        ),
      ),
    );
  }
}

class ReservationBottomWidget extends StatefulWidget {
  final Reservation reservation;
  final int index;

  const ReservationBottomWidget(this.reservation, this.index, {Key? key})
      : super(key: key);

  @override
  _ReservationBottomWidgetState createState() =>
      _ReservationBottomWidgetState();
}

class _ReservationBottomWidgetState extends State<ReservationBottomWidget> {
  bool _isCancelLoading = false;

  Future<void> _cancelReservation() async {
    setState(() {
      _isCancelLoading = true;
    });
    try {
      await Provider.of<ReservationsProvider>(context, listen: false)
          .deleteReservations(widget.reservation.guid);
    } on HttpException catch (error) {
      if (error.message == '401') {
        RefreshTokenHelper.refreshToken(
          context: context,
          successFunc: () {
            _cancelReservation();
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
      _isCancelLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: SizedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              color: Colors.black54,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ReservationTopDetails(
                          name: widget.reservation.location.name,
                          status: widget.reservation.status,
                        ), //ROW Widget
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: double.infinity,
                          height: 0.8,
                          color: Colors.white,
                        ),
                        ReservationRestaurantBottomDetails(widget.reservation),
                        _isCancelLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                ),
                              )
                            : widget.reservation.cancancel
                                ? CustomTextButton(
                                    text: 'Cancel Reservation',
                                    margin: 0,
                                    color: AppColors.secondaryColor,
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                    ),
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                    ),
                                    onPressed: () => _cancelReservation(),
                                  )
                                : const SizedBox(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReservationTopDetails extends StatefulWidget {
  final String name;
  final String status;

  ReservationTopDetails({
    required this.name,
    required this.status,
  });

  @override
  _ReservationTopDetailsState createState() => _ReservationTopDetailsState();
}

class _ReservationTopDetailsState extends State<ReservationTopDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(30),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       gradient: LinearGradient(
          //         colors: [
          //           Theme.of(context).primaryColor,
          //           Theme.of(context).canvasColor,
          //         ],
          //         begin: Alignment.centerLeft,
          //         end: Alignment.centerRight,
          //       ),
          //       borderRadius: const BorderRadius.all(
          //         Radius.circular(4),
          //       ),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(1),
          //           spreadRadius: 5,
          //           blurRadius: 7,
          //           offset: Offset(0, 3), // changes position of shadow
          //         ),
          //       ],
          //     ),
          //     child: Center(
          //       child: Text(
          //         widget.status,
          //         style: TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.normal,
          //           fontFamily: 'Avenir',
          //           color: Colors.white,
          //           shadows: [
          //             Shadow(
          //               offset: Offset(3.0, 3.0),
          //               blurRadius: 8.0,
          //               color: Color.fromARGB(255, 0, 0, 0),
          //             )
          //           ],
          //         ),
          //         textAlign: TextAlign.center,
          //         maxLines: 2,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
