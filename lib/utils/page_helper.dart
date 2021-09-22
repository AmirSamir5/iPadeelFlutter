import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/page_builder.dart';

abstract class PageHelper {
  Widget buildPage(PageBuilder pageBuilder) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, 0),
              colors: [
                AppColors.primaryColor,
                Colors.black,
              ],
              focal: Alignment.center,
              radius: 0.8,
            ),
          ),
        ),
        Scaffold(
          key: pageBuilder.scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: (pageBuilder.appbar)
              ? AppBar(
                  primary: true,
                  brightness: Brightness.light,
                  actions: pageBuilder.appBarActions ?? [],
                  leading: (pageBuilder.leading) ??
                      Semantics(
                        label: "Back",
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (pageBuilder.backButtonCallBack != null) {
                              FocusScope.of(pageBuilder.context).unfocus();
                              pageBuilder.backButtonCallBack!();
                            } else {
                              FocusScope.of(pageBuilder.context).unfocus();
                              Navigator.pop(pageBuilder.context);
                            }
                          },
                        ),
                      ),
                  title: Text(
                    pageBuilder.appBarTitle!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  iconTheme: const IconThemeData(color: Colors.black),
                )
              : null,
          body: (!pageBuilder.appbar)
              ? SafeArea(
                  child: _buildBody(pageBuilder),
                )
              : _buildBody(pageBuilder),
        ),
      ],
    );
  }

  _buildBody(PageBuilder pageBuilder) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(pageBuilder.context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: pageBuilder.body,
    );
  }
}
