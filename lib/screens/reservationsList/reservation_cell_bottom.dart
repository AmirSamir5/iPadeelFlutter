import 'package:flutter/material.dart';
import 'package:i_padeel/models/reservation.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';

class ReservationRestaurantBottomDetails extends StatelessWidget {
  final Reservation reservation;

  const ReservationRestaurantBottomDetails(this.reservation, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Wrap(
            direction: Axis.vertical,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReservationSpecificDetail(
                    icon: Icons.calendar_today,
                    detailsText: reservation.date,
                  ),
                  ReservationSpecificDetail(
                    icon: Icons.assignment,
                    detailsText: reservation.status,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReservationSpecificDetail(
                    icon: Icons.timer,
                    detailsText:
                        (reservation.fromTime) + ' - ' + (reservation.toTime),
                  ),
                  ReservationSpecificDetail(
                    icon: Icons.monetization_on,
                    detailsText: 'EGP ${reservation.cost}',
                  ),
                ],
              ),
              ReservationSpecificDetail(
                icon: Icons.mobile_screen_share,
                detailsText: reservation.mobile,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReservationSpecificDetail extends StatelessWidget {
  final IconData? icon;
  final String? detailsText;

  const ReservationSpecificDetail({Key? key, this.icon, this.detailsText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            detailsText ?? "S",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
