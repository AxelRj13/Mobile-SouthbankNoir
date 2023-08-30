import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

class SBLoading extends StatelessWidget {
  final Color? color;

  const SBLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoActivityIndicator();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.05,
      width: MediaQuery.of(context).size.width * 0.05,
      child: CircularProgressIndicator(
        color: color ?? accentColor,
        strokeWidth: 2.0,
      ),
    );
  }
}
