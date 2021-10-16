import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';

class CustomBottomSheetField extends StatefulWidget {
  const CustomBottomSheetField({
    Key? key,
    this.showLabelText = false,
    this.labelText,
    required this.hintText,
    required this.items,
    this.closeButton = true,
    this.hintStyle,
  }) : super(key: key);

  final bool showLabelText;
  final String? labelText;
  final String? hintText;
  final List<Widget> items;
  final bool closeButton;
  final TextStyle? hintStyle;

  @override
  _CustomBottomSheetFieldState createState() => _CustomBottomSheetFieldState();
}

class _CustomBottomSheetFieldState extends State<CustomBottomSheetField> {
  @override
  Widget build(BuildContext context) {
    return widget.showLabelText
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelText!,
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto-Medium',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              _dropDownField(),
            ],
          )
        : _dropDownField();
  }

  _dropDownField() {
    return InkWell(
      onTap: () {
        CustomBottomSheet.displayModalBottomSheet(
          context: context,
          items: widget.items,
          showCloseButton: widget.closeButton,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.hintText!,
              style: widget.hintStyle ??
                  const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto-Medium',
                    color: AppColors.hintTextColor,
                  ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.hintTextColor,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}

abstract class CustomBottomSheet {
  static void displayModalBottomSheet({
    required BuildContext context,
    bool isDismiss: true,
    required List<Widget> items,
    Color color: Colors.white,
    bool showCloseButton = true,
  }) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          children: [
            if (showCloseButton)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ...items
          ],
        ),
      ),
    );
  }
}
