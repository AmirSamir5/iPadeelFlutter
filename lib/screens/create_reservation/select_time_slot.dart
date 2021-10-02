import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/avaliable_slots.dart';
import 'package:i_padeel/models/courts.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/providers/avaliable_slots_provider.dart';
import 'package:i_padeel/screens/create_reservation/slots_widget.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/utils/shadow_text.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_text_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectTimeSlotWidget extends StatefulWidget {
  final Location _location;
  List<AvailableSlots>? _avaliableSLotsForLocation;
  SelectTimeSlotWidget({
    Key? key,
    required Location location,
  })  : _location = location,
        super(key: key);

  @override
  _SelectTimeSlotWidgetState createState() => _SelectTimeSlotWidgetState();
}

class _SelectTimeSlotWidgetState extends State<SelectTimeSlotWidget>
    with PageHelper {
  int _expandedIndex = -1;
  String? _formatted;
  String? _selectedDate;
  Slots? _selectedSLot;
  Courts? _selectedCourt;
  List<Slots>? slotsForSelectedDay;

  Future<void> _selectReservationDate(
      BuildContext context, Function(String?) onSelect) async {
    DateTime? pickedDate = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        currentTime: DateTime.now(),
        minTime: DateTime.now(),
        maxTime: DateTime(2120));
    final DateFormat formater = DateFormat('yyyy-MM-dd');

    if (pickedDate == null) {
      return;
    } else {
      _formatted = formater.format(pickedDate);
      onSelect(_formatted);
    }
  }

  void _getAvaliableSlots() {
    Provider.of<AvaliableTimeSLotsProvider>(context, listen: false)
        .fetchLocationSlots(widget._location.guid);
  }

  void _showErrorDialog(String message) {
    ShowDialogHelper.showErrorMessage(message, context);
  }

  void _resetSelection() {
    _selectedCourt = null;
    _selectedDate = null;
    _selectedSLot = null;
    _expandedIndex = -1;
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: _scaffoldkey,
        appBarTitle: 'Create Reservation',
        context: context,
        body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
            AppColors.backGroundColorLight,
            AppColors.backGroundColor
          ])),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: const Text(
                      'Select time slot',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: Container()),
                            TextButton(
                              onPressed: () => _selectReservationDate(context,
                                  (selectedDate) {
                                setState(() {
                                  _resetSelection();
                                  _selectedDate = selectedDate;
                                });
                                _getAvaliableSlots();
                              }),
                              child: const Text(
                                'Choose date',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        Consumer<AvaliableTimeSLotsProvider>(
                            builder: (ctx, prov, child) {
                          if (prov.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator(
                              backgroundColor: AppColors.secondaryColor,
                            ));
                          }
                          if (prov.failedToLoad) {
                            return GestureDetector(
                              onTap: () {
                                _getAvaliableSlots();
                              },
                              // ignore: sized_box_for_whitespace
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: const SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                      child: Icon(Icons.redo,
                                          color: AppColors.secondaryColor)),
                                ),
                              ),
                            );
                          }
                          widget._avaliableSLotsForLocation =
                              prov.locationSlots;
                          var slotsExistForSelectedDay = prov.locationSlots
                              .where((element) =>
                                  element.slotdate == _selectedDate)
                              .isNotEmpty;

                          if (_selectedDate != null &&
                              slotsExistForSelectedDay) {
                            slotsForSelectedDay = prov.locationSlots
                                .where((element) =>
                                    element.slotdate == _selectedDate)
                                .first
                                .slots;
                          }
                          if (!slotsExistForSelectedDay) {
                            var aDateIsSelected = _selectedDate == null;
                            _resetSelection();
                            return (aDateIsSelected)
                                ? Container()
                                : const Center(
                                    child: Text(
                                        'No avaliable slots for that day',
                                        style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 14)),
                                  );
                          } else {
                            return Column(
                              children: [
                                const Divider(
                                  color: Colors.white,
                                  thickness: 2.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        '${slotsForSelectedDay!.length} Avaliable time slots',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12))
                                  ],
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxHeight: 80),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            slotsForSelectedDay?.length ?? 0,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (ctx, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _expandedIndex = index;

                                                  _selectedSLot =
                                                      slotsForSelectedDay![
                                                          _expandedIndex];
                                                });
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(8),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: _expandedIndex == index
                                                      ? AppColors.secondaryColor
                                                      : Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: SlotsWidget(
                                                  fromTime:
                                                      slotsForSelectedDay![
                                                              index]
                                                          .fromTime
                                                          .toString(),
                                                  toTime: slotsForSelectedDay![
                                                          index]
                                                      .toTime
                                                      .toString(),
                                                ),
                                              ));
                                        }),
                                  ),
                                )
                              ],
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                  (_selectedSLot != null)
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: 32, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShadowText(
                                text: 'Select Court',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListView.builder(
                                  primary: false,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: _selectedSLot!.courts.length,
                                  itemBuilder: (ctx, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedCourt =
                                              _selectedSLot!.courts[i];
                                        });
                                      },
                                      child: Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        color: AppColors.backGroundColorLight,
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  _selectedSLot!.courts[i].name,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              (_selectedCourt ==
                                                      _selectedSLot!.courts[i])
                                                  // ignore: sized_box_for_whitespace
                                                  ? Container(
                                                      height: 28,
                                                      width: 28,
                                                      child: Image.asset(
                                                        "assets/images/check.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 5),
                                                      height: 20,
                                                      width: 20,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      child: const SizedBox(),
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
                  const SizedBox(height: 32),
                  CustomTextButton(
                    text: 'Reserve',
                    onPressed: () {
                      ShowDialogHelper.showDialogPopup(
                          "Congratulations",
                          "Your reservation has been completed successfully",
                          context, () {
                        Navigator.of(context).pop();
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
