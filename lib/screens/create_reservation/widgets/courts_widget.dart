import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/courts.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/providers/locations_provider.dart';
import 'package:i_padeel/utils/shadow_text.dart';
import 'package:provider/provider.dart';

class CourtsWidget extends StatefulWidget {
  final Location location;
  final Function(Courts) selectCourt;

  const CourtsWidget({
    Key? key,
    required this.location,
    required this.selectCourt,
  }) : super(key: key);

  @override
  _CourtsWidgetState createState() => _CourtsWidgetState();
}

class _CourtsWidgetState extends State<CourtsWidget> {
  Courts? _selectedCourt;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListView.builder(
                  primary: false,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.location.courts.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCourt = widget.location.courts[i];
                            widget.selectCourt(_selectedCourt!);
                          });
                        },
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.black,
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.location.courts[i].name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '(EGP ' +
                                            widget.location.slotPrice
                                                .toString() +
                                            ')',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                (_selectedCourt == widget.location.courts[i])
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
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: const SizedBox(),
                                      ),
                              ],
                            ),
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
      ],
    );
  }
}
