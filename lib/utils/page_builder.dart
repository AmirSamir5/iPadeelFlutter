import 'package:flutter/material.dart';

class PageBuilder {
  Widget? leading;
  bool appbar;
  bool enableDrawer;
  String? appBarTitle;
  GlobalKey<ScaffoldState> scaffoldKey;
  Widget body;
  BuildContext context;
  Function? backButtonCallBack;
  List<Widget>? appBarActions;

  PageBuilder(
      {this.appBarActions,
      this.enableDrawer = false,
      required this.scaffoldKey,
      this.backButtonCallBack,
      this.appBarTitle = "",
      this.appbar = true,
      required this.context,
      this.leading,
      required this.body});
}
