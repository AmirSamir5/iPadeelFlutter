import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/screens/reservationsList/reservations_list_screen.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:provider/provider.dart';

class DiscoverButtonWidget extends StatelessWidget {
  const DiscoverButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<AuthProvider>(context).isAccountAuthenticated;
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/discover_buttons.svg',
          height: 180,
          width: MediaQuery.of(context).size.width,
        ),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width / 180),
          shrinkWrap: true,
          crossAxisSpacing: 23,
          mainAxisSpacing: 23,
          children: [
            GestureDetector(
              onTap: isAuth
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReservationsListScreen(),
                        ),
                      );
                    }
                  : () {
                      ShowDialogHelper.showDialogPopup(
                        'Attention',
                        'You must Login First',
                        context,
                        () => Navigator.of(context).pop(),
                      );
                    },
            ),
            GestureDetector(
              onTap: () => print('training tapped'),
            ),
            GestureDetector(
              onTap: () => print('tournament tapped'),
            ),
            GestureDetector(
              onTap: () => print('invite friend tapped'),
            )
          ],
        ),
      ],
    );
  }
}
