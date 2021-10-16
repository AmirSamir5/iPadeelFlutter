import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final Color? color;
  final double? margin;
  final TextStyle? textStyle;
  final Widget? icon;

  CustomTextButton({
    this.color,
    this.onPressed,
    this.margin,
    required this.text,
    this.textStyle,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 32),
        decoration: BoxDecoration(
          color: color ?? AppColors.secondaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        height: 55,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const SizedBox(),
              const SizedBox(width: 4),
              Text(
                text!,
                style: textStyle ?? Theme.of(context).textTheme.button,
              ),
            ],
          ),
        ),
      ),
      onPressed: (onPressed != null) ? onPressed : () {},
    );
  }
}
