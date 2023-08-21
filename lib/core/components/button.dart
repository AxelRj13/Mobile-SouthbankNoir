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
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size.fromHeight(50.0),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(color ?? accentColor),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
