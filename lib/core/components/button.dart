import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

class SBButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Color? color;

  const SBButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? accentColor;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: buttonColor,
        disabledBackgroundColor: buttonColor.withOpacity(.5),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
