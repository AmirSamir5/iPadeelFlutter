import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';

import 'custom_input_field.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.passwordController,
    required this.obscureText,
    required this.callback,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.showLabelText = false,
    this.isKeyboardDigitsOnly = false,
  }) : super(key: key);

  final TextEditingController passwordController;
  final bool obscureText;
  final Function callback;
  final String? hintText;
  final String? labelText;
  final bool showLabelText;
  final TextInputType keyboardType;
  final bool isKeyboardDigitsOnly;

  @override
  Widget build(BuildContext context) {
    return CustomTextInputField(
      basicInputKey: UniqueKey(),
      controller: passwordController,
      keyboardType: keyboardType,
      hintText: hintText ?? 'Enter Your Password',
      showLabelText: showLabelText,
      labelText: labelText,
      obscureText: obscureText,
      suffixIcon: GestureDetector(
        onTap: callback as void Function()?,
        child: Icon(
          !obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.hintTextColor,
        ),
      ),
      prefixIcon: const Icon(Icons.lock, color: AppColors.hintTextColor),
      isKeyboardDigitsOnly: isKeyboardDigitsOnly,
      validateEmptyString: true,
    );
  }
}
