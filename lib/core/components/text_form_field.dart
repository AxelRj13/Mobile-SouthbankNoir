import 'package:flutter/material.dart';

class SBTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final bool? isPassword;
  final bool? isMultiline;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? suffixIcon;

  const SBTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textInputType,
    this.isPassword = false,
    this.isMultiline = false,
    this.validator,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      autocorrect: false,
      obscureText: isPassword!,
      onTap: onTap,
      keyboardType: textInputType,
      maxLines: isMultiline! ? 5 : 1,
    );
  }
}
