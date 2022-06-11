import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/avaliable_slots.dart';
import 'package:i_padeel/models/courts.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/providers/avaliable_slots_provider.dart';
import 'package:i_padeel/providers/locations_provider.dart';
import 'package:i_padeel/providers/user_provider.dart';
import 'package:i_padeel/screens/create_reservation/widgets/courts_widget.dart';
import 'package:i_padeel/screens/create_reservation/widgets/time_slot_widget.dart';
import 'package:i_padeel/screens/profile/verification_screen.dart';
import 'package:i_padeel/utils/constants.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationScreen extends StatefulWidget {
  final Location location;
  ReservationScreen({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> with PageHelper {
  bool _loadingCreateReservation = false;
  bool _isInit = true;
  bool _isLoading = true;
  List<AvailableSlots>? _availableSlots;
  List<Slots>? _slots;
  List<Slots>? _selectedSlot;
  Courts? _selectedCourt;

  @override
  void initState() {
    if (_isInit) {
      _getAvaliableSlots();
      _isInit = false;
    }
    super.initState();
  }

  void _getAvaliableSlots() async {
    try {
      await Provider.of<AvaliableTimeSLotsProvider>(context, listen: false)
          .fetchLocationSlots(widget.location.guid);
      _availableSlots =
          Provider.of<AvaliableTimeSLotsProvider>(context, listen: false)
              .availableSlots;
    } on HttpException catch (error) {
      ShowDialogHelper.showDialogPopup('Faild', error.message, context, () {
        Navigator.of(context).pop();
      });
    } on SocketException catch (_) {
      ShowDialogHelper.showDialogPopup(
          'Faild', 'Please Check Internet Connection', context, () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      ShowDialogHelper.showDialogPopup(
          'Faild', 'Sorry, an unexpected error has occurred.', context, () {
        Navigator.of(context).pop();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _createReservation() async {
    if (_selectedCourt == null || _selectedSlot == null) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.getString(Constant.prefsUserAccessTokenKey);
    if (accessToken == null) {
      _showErrorDialog("Please login first before making a reservation");
      return;
    }
    var user =
        await Provider.of<UserProvider>(context, listen: false).getUserData();

    var mobileNumber = user?.phone;
    if (mobileNumber == null) {
      ShowDialogHelper.showDialogPopup(
          "", "Please login before making a reservation", context, () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
      return;
    }

    var verified = prefs.getBool(Constant.prefsUserIsVerifiedKey);

    if (verified == null || verified != true) {
      ShowDialogHelper.showDialogPopupWithCancel(
        "Warning",
        "Please verify your phone number before making a reservation",
        context,
        () {
          Navigator.of(context).pop();
        },
        () {
          Navigator.of(context).pop();

          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) =>
                  VerificationScreen(mobileNumber: mobileNumber)));
        },
      );
      return;
    }

    setState(() {
      _loadingCreateReservation = true;
    });
    try {
      await Provider.of<LocationsProvider>(context, listen: false)
          .createReservation(
        _selectedCourt!.guid,
        _selectedSlot!,
      );
      setState(() {
        _loadingCreateReservation = false;
      });
      ShowDialogHelper.showDialogPopup(
          "Congratulations",
          "Your reservation has been completed successfully, You can cancel your reserveration till 4 hours before reservation time",
          context, () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } catch (error) {
      setState(() {
        _loadingCreateReservation = false;
      });
      _showErrorDialog("Something went wrong,Please try again later");
    }
  }

  void _showErrorDialog(String message) {
    ShowDialogHelper.showErrorMessage(message, context);
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Create Reservation',
        context: context,
        body: SingleChildScrollView(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryColor,
                  ),
                )
              : _availableSlots != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CourtsWidget(
                          location: widget.location,
                          selectCourt: (court) {
                            setState(() {
                              _selectedCourt = court;
                              _slots = _availableSlots!
                                  .singleWhere(
                                      (element) => element.name == court.name)
                                  .slots;
                            });
                          },
                        ),
                        _selectedCourt != null && _slots != null
                            ? TimeSlotWidget(
                                slots: _slots!,
                                location: widget.location,
                                selectedSlots: (slot) {
                                  setState(() {
                                    _selectedSlot = slot;
                                  });
                                },
                              )
                            : Container(),
                        const SizedBox(height: 32),
                        _selectedCourt != null && _selectedSlot != null
                            ? _loadingCreateReservation
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),
                                  )
                                : CustomTextButton(
                                    text: 'Reserve',
                                    onPressed: () {
                                      _createReservation();
                                    },
                                  )
                            : Container()
                      ],
                    )
                  : Container(),
        ),
      ),
    );
  }
}
