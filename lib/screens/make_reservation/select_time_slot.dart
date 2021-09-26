import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/slots.dart';
import 'package:i_padeel/screens/make_reservation/slots_widget.dart';
import 'package:i_padeel/utils/shadow_text.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:intl/intl.dart';

class SelectTimeSlotWidget extends StatefulWidget {
  String _restId;
  SelectTimeSlotWidget({
    Key? key,
    required String resId,
  })  : _restId = resId,
        super(key: key);

  @override
  _SelectTimeSlotWidgetState createState() => _SelectTimeSlotWidgetState();
}

class _SelectTimeSlotWidgetState extends State<SelectTimeSlotWidget> {
  var _isTimeSlotsLoading = false;

  List<Slot> _slots = [];

  int _expandedIndex = -1;
  String? _formatted;
  String? _selectedDate;
  String? _fromTime;
  String? _toTime;
  List<String> _branches = ["court 1", "court 2"];
  int? _selectedBranchIndex;

  Future<void> _selectReservationDate(BuildContext context) async {
    DateTime? pickedDate = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        currentTime: DateTime.now(),
        minTime: DateTime.now(),
        maxTime: DateTime(2120));
    final DateFormat formater = DateFormat('yyyy-MM-dd');
    _formatted = formater.format(pickedDate!);
    if (pickedDate == null) {
      return;
    } else {
      setState(() {
        _selectedDate = _formatted;
        _getAvailableSlots();
      });
    }
  }

  Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  Future<void> _getAvailableSlots() async {
    try {
      setState(() {
        _isTimeSlotsLoading = true;
      });

      /* await Provider.of<SlotProvider>(context)
          .getAvailableSlots(_areaId, _selectedDate);
      _slots = Provider.of<SlotProvider>(context, listen: false).slots;*/

      _slots = [
        Slot(
            isoFrom: "12:00:00",
            isoTo: "12:30:00",
            fromTime: "12:00 PM",
            toTime: "12:30 PM",
            seats: 0),
        Slot(
            isoFrom: "12:00:00",
            isoTo: "12:30:00",
            fromTime: "12:00 PM",
            toTime: "12:30 PM",
            seats: 0),
        Slot(
            isoFrom: "12:00:00",
            isoTo: "12:30:00",
            fromTime: "12:00 PM",
            toTime: "12:30 PM",
            seats: 0),
        Slot(
            isoFrom: "12:00:00",
            isoTo: "12:30:00",
            fromTime: "12:00 PM",
            toTime: "12:30 PM",
            seats: 0),
        Slot(
            isoFrom: "12:00:00",
            isoTo: "12:30:00",
            fromTime: "12:00 PM",
            toTime: "12:30 PM",
            seats: 0),
        Slot(
            isoFrom: "12:00:00",
            isoTo: "12:30:00",
            fromTime: "12:00 PM",
            toTime: "12:30 PM",
            seats: 0)
      ];

      setState(() {
        _isTimeSlotsLoading = false;
      });
    } on HttpException catch (error) {
      if (error.message == '401') {
        /* RefreshTokenHelper.refreshToken(
          context: context,
          successFunc: () {
            _getAvailableSlots();
          },
          timeoutFunc: () {
            setState(() {
              _isTimeSlotsLoading = false;
            });
          },
        );*/
      } else {
        _showErrorDialog(error.message);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
      }
    } on SocketException catch (_) {
      _showErrorDialog("Please check your internet connection and try again");
    } catch (error) {
      _showErrorDialog("Sorry, an unexpected error has occurred.");
    }
    setState(() {
      _isTimeSlotsLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    ShowDialogHelper.showErrorMessage(message, context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        width: MediaQuery.of(context).size.width,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Arrival Time',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ShadowText(
                            text: _formatted ?? 'No date chosen',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                          Expanded(child: Container()),
                          TextButton(
                            onPressed: () => _selectReservationDate(context),
                            child: const Text(
                              'Choose date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                      if (_selectedDate != null)
                        Divider(
                          color: Colors.white,
                          thickness: 2.0,
                        ),
                      if (_selectedDate != null)
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('5 Avaliable time slots',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))
                          ],
                        ),
                      if (_formatted != null)
                        (_isTimeSlotsLoading)
                            ? const Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.white),
                              )
                            : Flexible(
                                flex: 3,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxHeight: 80),
                                    child: _slots.isEmpty
                                        ? Center(
                                            child: Text(
                                              'No time slots available',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: _slots.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (ctx, index) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _expandedIndex = index;

                                                      _fromTime =
                                                          _slots[_expandedIndex]
                                                              .isoFrom;
                                                      _toTime =
                                                          _slots[_expandedIndex]
                                                              .isoTo;
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(8),
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          _expandedIndex ==
                                                                  index
                                                              ? AppColors
                                                                  .secondaryColor
                                                              : Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: SlotsWidget(
                                                      fromTime: _slots[index]
                                                          .fromTime
                                                          .toString(),
                                                      toTime: _slots[index]
                                                          .toTime
                                                          .toString(),
                                                      seats:
                                                          _slots[index].seats,
                                                    ),
                                                  ));
                                            }),
                                  ),
                                ),
                              )
                    ],
                  ),
                ),
              ),
              (_fromTime != null && _toTime != null)
                  ? Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShadowText(
                            text: 'Select Court',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.all(16),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: _branches.length,
                              itemBuilder: (ctx, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print("clicked");
                                      _selectedBranchIndex = i;
                                    });
                                  },
                                  child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    color: AppColors.backGroundColorLight,
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _branches[i],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          (_selectedBranchIndex == i)
                                              ? Container(
                                                  height: 28,
                                                  width: 28,
                                                  child: Image.asset(
                                                    "assets/images/check.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: SizedBox(),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Center(
                child: Container(
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),

                  margin: EdgeInsets.fromLTRB(32, 24, 32, 24),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  child: TextButton(
                      child: ShadowText(
                        text: ' Create reservation',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        ShowDialogHelper.showDialogPopup(
                            "Congratulations",
                            "Your reservation has been completed successfully",
                            context, () {
                          Navigator.of(context).pop();
                        });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
