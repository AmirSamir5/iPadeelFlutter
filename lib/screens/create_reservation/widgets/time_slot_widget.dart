import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/avaliable_slots.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/providers/avaliable_slots_provider.dart';
import 'package:i_padeel/providers/locations_provider.dart';
import 'package:i_padeel/utils/shadow_text.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../slots_widget.dart';

class TimeSlotWidget extends StatefulWidget {
  final Location location;
  final Function(Slots) selectedSlots;
  final Function(String) selectedDate;

  const TimeSlotWidget({
    Key? key,
    required this.location,
    required this.selectedSlots,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _TimeSlotWidgetState createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  int _expandedIndex = -1;
  String? _formatted;
  String? _selectedDate;
  Slots? _selectedSLot;
  List<Slots>? slotsForSelectedDay;

  Future<void> _selectReservationDate(
      BuildContext context, Function(String?) onSelect) async {
    DateTime minDate = DateTime.now();
    DateTime maxDate = DateTime.now().add(const Duration(days: 7));
    CustomBottomSheet.displayModalBottomSheet(context: context, items: [
      TableCalendar(
        firstDay: minDate,
        lastDay: maxDate,
        focusedDay: DateTime.now(),
        daysOfWeekVisible: true,
        onDaySelected: (selectedDay, focusedDay) {
          final DateFormat formater = DateFormat('yyyy-MM-dd');

          _formatted = formater.format(selectedDay);
          onSelect(_formatted);
          Navigator.of(context).pop();
        },
      )
    ]);
  }

  void _showErrorDialog(String message) {
    ShowDialogHelper.showErrorMessage(message, context);
  }

  void _getAvaliableSlots() {
    Provider.of<AvaliableTimeSLotsProvider>(context, listen: false)
        .fetchLocationSlots(widget.location.guid);
  }

  void _resetSelection() {
    Provider.of<LocationsProvider>(context, listen: false).selectedDate = null;
    Provider.of<LocationsProvider>(context, listen: false).selectedSLot = null;
    _expandedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.white)),
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
                    onPressed: () =>
                        _selectReservationDate(context, (selectedDate) {
                      setState(() {
                        _resetSelection();
                        _selectedDate = selectedDate;
                        widget.selectedDate(_selectedDate!);
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
              Consumer<AvaliableTimeSLotsProvider>(builder: (ctx, prov, child) {
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
                        height: 100,
                        width: 100,
                        child: Center(
                            child: Icon(Icons.refresh,
                                color: AppColors.secondaryColor)),
                      ),
                    ),
                  );
                }
                var slotsExistForSelectedDay = prov.locationSlots
                    .where((element) => element.slotdate == _selectedDate)
                    .isNotEmpty;

                if (_selectedDate != null && slotsExistForSelectedDay) {
                  slotsForSelectedDay = prov.locationSlots
                      .where((element) => element.slotdate == _selectedDate)
                      .first
                      .slots;
                }
                if (!slotsExistForSelectedDay) {
                  var aDateIsSelected = _selectedDate == null;
                  _resetSelection();
                  return (aDateIsSelected)
                      ? Container()
                      : Center(
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            child: const Text(
                              'No avaliable slots for that day',
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 80),
                          child: slotsForSelectedDay!.isEmpty
                              ? Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(16),
                                    child: const Text(
                                      'No avaliable slots for that day',
                                      style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: slotsForSelectedDay?.length ?? 0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _expandedIndex = index;

                                            _selectedSLot =
                                                slotsForSelectedDay![
                                                    _expandedIndex];
                                            widget
                                                .selectedSlots(_selectedSLot!);
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          padding: const EdgeInsets.all(8),
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
                                                slotsForSelectedDay![index]
                                                    .fromTime
                                                    .toString(),
                                            toTime: slotsForSelectedDay![index]
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
        )
      ],
    );
  }
}
