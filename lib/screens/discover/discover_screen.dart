import 'package:flutter/material.dart';
import 'package:i_padeel/screens/discover/widgets/discover_button_widget.dart';
import 'package:i_padeel/screens/discover/widgets/discover_locations_list.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:slide_drawer/slide_drawer.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        leading: IconButton(
          onPressed: () => SlideDrawer.of(context)?.toggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        appBarActions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Home',
        context: context,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                flex: 2,
                child: DiscoverButtonWidget(),
              ),
              Expanded(
                flex: 3,
                child: DiscoverLocationsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
