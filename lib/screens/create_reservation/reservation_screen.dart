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
import 'package:i_padeel/utils/shadow_text.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationScreen extends StatefulWidget {
  final Location location;
  List<AvailableSlots>? _avaliableSLotsForLocation;
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

  @override
  void initState() {
    if (_isInit) {
      _isInit = false;
      Provider.of<LocationsProvider>(context, listen: false).selectedDate =
          null;
      Provider.of<LocationsProvider>(context, listen: false).selectedCourt =
          null;
      Provider.of<LocationsProvider>(context, listen: false).selectedSLot =
          null;
    }
    super.initState();
  }

  Future<void> _createReservation() async {
    if (Provider.of<LocationsProvider>(context, listen: false).selectedDate ==
            null ||
        Provider.of<LocationsProvider>(context, listen: false).selectedCourt ==
            null ||
        Provider.of<LocationsProvider>(context, listen: false).selectedSLot ==
            null) {
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
        Provider.of<LocationsProvider>(context, listen: false).selectedDate!,
        Provider.of<LocationsProvider>(context, listen: false)
            .selectedCourt!
            .guid,
        Provider.of<LocationsProvider>(context, listen: false)
            .selectedSLot!
            .fromTime,
        Provider.of<LocationsProvider>(context, listen: false)
            .selectedSLot!
            .toTime,
      );
      setState(() {
        _loadingCreateReservation = false;
      });
      ShowDialogHelper.showDialogPopup("Congratulations",
          "Your reservation has been completed successfully", context, () {
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
          child: _loadingCreateReservation
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CourtsWidget(
                      location: widget.location,
                      selectCourt: (court) {
                        setState(() {
                          Provider.of<LocationsProvider>(context, listen: false)
                              .selectedCourt = court;
                        });
                      },
                    ),
                    Provider.of<LocationsProvider>(context, listen: false)
                                .selectedCourt !=
                            null
                        ? TimeSlotWidget(
                            location: widget.location,
                            selectedSlots: (slot) {
                              setState(() {
                                Provider.of<LocationsProvider>(context,
                                        listen: false)
                                    .selectedSLot = slot;
                              });
                            },
                            selectedDate: (date) {
                              setState(() {
                                Provider.of<LocationsProvider>(context,
                                        listen: false)
                                    .selectedDate = date;
                              });
                            },
                          )
                        : Container(),
                    const SizedBox(height: 32),
                    (Provider.of<LocationsProvider>(context, listen: false)
                                    .selectedDate !=
                                null &&
                            Provider.of<LocationsProvider>(context,
                                        listen: false)
                                    .selectedCourt !=
                                null &&
                            Provider.of<LocationsProvider>(context,
                                        listen: false)
                                    .selectedSLot !=
                                null)
                        ? CustomTextButton(
                            text: 'Reserve',
                            onPressed: () {
                              _createReservation();
                            },
                          )
                        : Container()
                  ],
                ),
        ),
      ),
    );
  }
}
