import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiscoverButtonWidget extends StatelessWidget {
  const DiscoverButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/discover_buttons.svg',
          height: 200,
          width: MediaQuery.of(context).size.width,
        ),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width / 200),
          shrinkWrap: true,
          crossAxisSpacing: 23,
          mainAxisSpacing: 23,
          children: [
            GestureDetector(
              onTap: () => print('booking tapped'),
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
