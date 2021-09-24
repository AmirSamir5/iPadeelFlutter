import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_padeel/constants/app_colors.dart';

class CustomTextInputField extends StatefulWidget {
  final FormFieldValidator<String>? validationMethod;
  final String? hintText;
  final String? errorLabel;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final Key? basicInputKey;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? semanticsLabelKey;
  final String? errorLabelKey;
  final bool enabled;
  final Widget? icon;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final TextAlign? textAlign;
  final bool validateEmptyString;
  final bool validateZeroNumber;
  final bool clearIcon;
  final double? borderRadius;
  final Color? borderColor;
  final bool isKeyboardDigitsOnly;
  final List<TextInputFormatter>? inputFormatter;
  final bool obscureText;
  final bool showLabelText;
  final String? labelText;
  final Color fillColor;

  // final bool obscureText;
  // final String initialValue;

  CustomTextInputField({
    this.enabled = true,
    this.obscureText = false,
    this.isKeyboardDigitsOnly = false,
    // this.initialValue = "",
    this.prefixIcon,
    this.clearIcon = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validationMethod,
    this.icon,
    this.hintText = '',
    this.errorLabel,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.basicInputKey,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.semanticsLabelKey,
    this.errorLabelKey,
    Key? key,
    this.maxLength,
    this.textAlign,
    this.inputFormatter,
    this.validateEmptyString = false,
    this.borderRadius,
    this.borderColor,
    this.validateZeroNumber = false,
    this.showLabelText = false,
    this.labelText,
    this.fillColor = Colors.white,
  }) : super(key: key);

  @override
  _CustomTextInputFieldState createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  FocusNode? _myFocusNode;
  Key? _basicInputKey;
  TextEditingController? _textController;

  @override
  void initState() {
    _basicInputKey = (widget.basicInputKey == null)
        ? const Key('basic_input')
        : widget.basicInputKey;
    _myFocusNode = (widget.focusNode == null) ? FocusNode() : widget.focusNode;
    _textController = (widget.controller == null)
        ? TextEditingController()
        : widget.controller;
    super.initState();
  }

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
                  color: Colors.black,
                ),
              ),
              _textFormField(),
            ],
          )
        : _textFormField();
  }

  _textFormField() {
    return Semantics(
      label: widget.semanticsLabelKey,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            TextFormField(
              obscureText: widget.obscureText,
              textAlign: widget.textAlign ?? TextAlign.start,
              maxLength: widget.maxLength,
              cursorColor: AppColors.hintTextColor,
              key: _basicInputKey,
              textInputAction: widget.textInputAction,
              enabled: widget.enabled,
              focusNode: _myFocusNode,
              controller: _textController,
              keyboardType: widget.keyboardType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              validator: (val) {
                if (val == null) {
                  return 'Please enter correct' +
                      (widget.errorLabel ?? widget.labelText ?? "");
                }
                if (widget.validateEmptyString &&
                    (val.isEmpty || val.trim().isEmpty)) {
                  return 'Please enter correct' +
                      (widget.errorLabel ?? widget.labelText ?? "");
                }
                //  else if (widget.validateZeroNumber &&
                //     widget.keyboardType.index == 2 &&
                //     Validators.checkIFAllZero(val)) {
                //   return AppLocalizations.of(context)!
                //           .translate(widget.labelText!)! +
                //       AppLocalizations.of(context)!
                //           .translate("must_not_be_zero")!;
                // }
                //will check for validation method lastly
                if (widget.validationMethod != null) {
                  return widget.validationMethod!(val);
                }

                return null;
              },
              inputFormatters: widget.inputFormatter ??
                  <TextInputFormatter>[
                    if (widget.isKeyboardDigitsOnly)
                      FilteringTextInputFormatter.digitsOnly
                  ],
              // Only numbers
              decoration: InputDecoration(
                fillColor: widget.fillColor,
                filled: true,
                errorMaxLines: 4,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                counterStyle: const TextStyle(
                  height: double.minPositive,
                ),
                counterText: "",
                prefixIcon: widget.prefixIcon,
                // suffix: (widget.clearIcon) //&& widget.controller.text.isNotEmpty
                //     ? null
                //     : widget.suffixIcon,
                suffixIcon: (widget.clearIcon &&
                        widget.controller!.text.isNotEmpty)
                    ? GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          setState(() {
                            widget.controller!.clear();
                            if (widget.onChanged != null) widget.onChanged!("");
                          });
                        },
                      )
                    : widget.suffixIcon != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [widget.suffixIcon!],
                          )
                        : null,
                errorStyle: const TextStyle(
                  color: AppColors.primaryColor,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.hintTextColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.hintTextColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(
                    color: AppColors.hintTextColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.hintTextColor,
                  ),
                ),

                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto-Medium',
                  color: AppColors.hintTextColor,
                ),
                alignLabelWithHint: true,
              ),
              onChanged: (val) {
                (widget.onChanged != null) ? widget.onChanged!(val) : () {};
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _myFocusNode!.dispose();
    super.dispose();
  }
}
