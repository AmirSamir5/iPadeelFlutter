import 'package:flutter/material.dart';
import 'package:i_padeel/screens/home/widgets/discover_button_widget.dart';
import 'package:i_padeel/screens/home/widgets/discover_locations_list.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:slide_drawer/slide_drawer.dart';

class HomeScreen extends StatefulWidget {
  final Function(BuildContext)? returnContext;
  const HomeScreen({Key? key, this.returnContext}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool _isInit = true;

  @override
  void initState() {
    if (_isInit) {
      _isInit = false;
      if (widget.returnContext == null) return;
      widget.returnContext!(context);
    }
    super.initState();
  }

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
        // appBarActions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.search,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Home',
        context: context,
        body: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                flex: 1,
                child: DiscoverButtonWidget(),
              ),
              Expanded(
                flex: 2,
                child: DiscoverLocationsList(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(28),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Image.asset(
                      'assets/images/home-photo.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
