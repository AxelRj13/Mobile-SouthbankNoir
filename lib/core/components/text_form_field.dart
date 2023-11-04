import 'package:flutter/material.dart';

class SBTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final bool? isPassword;
  final bool? isMultiline;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final Color? focusColor;
  final InputBorder? focusedBorder;

  const SBTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textInputType,
    this.isPassword = false,
    this.isMultiline = false,
    this.validator,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.fillColor = Colors.transparent,
    this.contentPadding,
    this.enabledBorder,
    this.focusColor,
    this.focusedBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            hintText: hintText,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor,
            contentPadding: contentPadding,
            enabledBorder: enabledBorder,
            focusColor: focusColor,
            focusedBorder: focusedBorder,
          ),
      validator: validator,
      autocorrect: false,
      obscureText: isPassword!,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: textInputType,
      maxLines: isMultiline! ? 5 : 1,
    );
  }
}
