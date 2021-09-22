import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final Color? color;
  final double? margin;

  CustomTextButton({
    this.color,
    this.onPressed,
    this.margin,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 32),
        decoration: BoxDecoration(
            color: color ?? AppColors.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        height: 55,
        child: Center(
          child: Text(
            text!,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
      onPressed: (onPressed != null) ? onPressed : () {},
    );
  }
}
