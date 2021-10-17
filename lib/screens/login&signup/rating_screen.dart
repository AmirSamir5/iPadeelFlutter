import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/ratings.dart';
import 'package:i_padeel/models/user.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/providers/ratings_provider.dart';
import 'package:i_padeel/providers/user_provider.dart';
import 'package:i_padeel/screens/login&signup/widgets/rating_item.dart';
import 'package:i_padeel/screens/profile/verification_screen.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class RatingsScreen extends StatefulWidget {
  final User user;
  final File? pickedImage;
  final Function? registerSuccess;
  final Function? editSuccess;
  bool isEdit;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RatingsScreen({
    Key? key,
    required this.user,
    this.registerSuccess,
    this.editSuccess,
    this.isEdit = false,
    this.pickedImage,
  }) : super(key: key);

  @override
  _RatingsScreenState createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> with PageHelper {
  bool _isLoading = true;
  bool _isRegisteredLoading = false;
  bool _isInit = true;
  List<Ratings> _ratingsList = [];

  @override
  void initState() {
    if (_isInit) {
      _getRatings();
      _isInit = false;
    }
    super.initState();
  }

  Future<void> _getRatings() async {
    try {
      await Provider.of<RatingsProvider>(context, listen: false).getRatings();
      _ratingsList =
          Provider.of<RatingsProvider>(context, listen: false).ratingsList;
    } on HttpException catch (error) {
      ShowDialogHelper.showDialogPopup('Error!', error.message, context, () {
        Navigator.of(context).pop();
      });
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

  Future _registerOrEditUser() async {
    if (widget.user.rating == null) {
      ShowDialogHelper.showDialogPopup(
          'Error', 'Please Select Rating First', context, () {
        Navigator.of(context).pop();
      });
      return;
    }
    setState(() {
      _isRegisteredLoading = true;
    });
    try {
      widget.isEdit
          ? await Provider.of<UserProvider>(context, listen: false)
              .editUserProfile(widget.user, widget.pickedImage)
          : await Provider.of<AuthProvider>(context, listen: false)
              .registerUser(widget.user, widget.pickedImage);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Future.delayed(Duration.zero, () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) =>
                VerificationScreen(mobileNumber: widget.user.phone!)));
      });
      if (!widget.isEdit) widget.registerSuccess!();
    } on HttpException catch (error) {
      ShowDialogHelper.showDialogPopup('Error', error.message, context, () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } on SocketException catch (_) {
      ShowDialogHelper.showDialogPopup(
          'Error',
          'please check your internet connection and try again later',
          context, () {
        Navigator.of(context).pop();
      });
    } catch (error) {
      ShowDialogHelper.showDialogPopup(
          'Authentication Failed', error.toString(), context, () {
        Navigator.of(context).pop();
      });
    }
    setState(() {
      _isRegisteredLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: widget.scaffoldKey,
        context: context,
        body: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Please select a rate regarding to the british padel rating system',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'RATING',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )),
                  Flexible(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'PLAYING DESCRIPTION',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'DIVISION',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondaryColor,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          Ratings rating = _ratingsList[index];
                          return RatingItemWidget(
                            selectedRating: widget.user.rating,
                            ratings: rating,
                            index: index,
                            selectedRatingFunction: (rating) {
                              setState(() {
                                widget.user.rating = rating;
                              });
                            },
                          );
                        },
                        itemCount: _ratingsList.length,
                      ),
              ),
              _isRegisteredLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                    )
                  : CustomTextButton(
                      text: widget.isEdit ? 'Edit Profile' : 'Register',
                      onPressed: () {
                        _registerOrEditUser();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
