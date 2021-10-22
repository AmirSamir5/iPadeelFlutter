import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:slide_drawer/slide_drawer.dart';

class CourtsScreen extends StatefulWidget {
  final Function(BuildContext)? returnContext;
  const CourtsScreen({Key? key, this.returnContext}) : super(key: key);

  @override
  _CourtsScreenState createState() => _CourtsScreenState();
}

class _CourtsScreenState extends State<CourtsScreen> with PageHelper {
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
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Courts',
        context: context,
        extendbody: true,
        leading: IconButton(
          onPressed: () => SlideDrawer.of(context)?.toggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body: Container(
          color: AppColors.primaryColor,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/coming-soon.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
