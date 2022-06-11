import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/avaliable_slots.dart';
import 'package:i_padeel/utils/shadow_text.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../models/location.dart';
import '../slots_widget.dart';

class TimeSlotWidget extends StatefulWidget {
  final List<Slots> slots;
  final Location location;
  final Function(List<Slots>) selectedSlots;

  const TimeSlotWidget({
    Key? key,
    required this.slots,
    required this.location,
    required this.selectedSlots,
  }) : super(key: key);

  @override
  _TimeSlotWidgetState createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  String? _formatted;
  DateTime dateSelected = DateTime.now();
  String? _selectedDate;
  List<Slots> _selectedSlots = [];
  List<Slots> slots = [];

  Future<void> _selectReservationDate(
      BuildContext context, Function(String?) onSelect) async {
    DateTime minDate = DateTime.now();
    DateTime maxDate = DateTime.now().add(const Duration(days: 7));
    CustomBottomSheet.displayModalBottomSheet(context: context, items: [
      TableCalendar(
        firstDay: minDate,
        lastDay: maxDate,
        focusedDay: dateSelected,
        selectedDayPredicate: (day) => isSameDay(day, dateSelected),
        daysOfWeekVisible: true,
        onDaySelected: (selectedDay, focusedDay) {
          final DateFormat formater = DateFormat('yyyy-MM-dd');
          setState(() {
            dateSelected = selectedDay;
          });
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
                        _selectedDate = selectedDate;
                        slots = widget.slots
                            .where((element) =>
                                element.fromTime.split('T')[0] == selectedDate)
                            .toList();
                      });
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
              Column(
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
                      Expanded(
                        child: slots.isNotEmpty
                            ? Text(
                                '${slots.length} Avaliable time slots (Select Max 3 slots)',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12))
                            : const Text('0 Avaliable time slots',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 80),
                      child: _selectedDate == null
                          ? Center(
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                child: const Text(
                                  'Please choose a date',
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : slots.isEmpty
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
                                  itemCount: widget.slots.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    var indexExists = _selectedSlots
                                        .contains(widget.slots[index]);
                                    return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (indexExists) {
                                              _selectedSlots.length == 1
                                                  ? _selectedSlots = []
                                                  : _selectedSlots.removeWhere(
                                                      (element) =>
                                                          element ==
                                                          widget.slots[index]);
                                              return;
                                            }
                                            if (_selectedSlots.length < 3) {
                                              _selectedSlots
                                                  .add(widget.slots[index]);
                                            } else {
                                              _selectedSlots.removeAt(0);
                                              _selectedSlots
                                                  .add(widget.slots[index]);
                                            }

                                            widget
                                                .selectedSlots(_selectedSlots);
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: indexExists
                                                ? AppColors.secondaryColor
                                                : Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: SlotsWidget(
                                            fromTime: widget
                                                .slots[index].fromTime
                                                .toString(),
                                            toTime: widget.slots[index].toTime
                                                .toString(),
                                          ),
                                        ));
                                  }),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
