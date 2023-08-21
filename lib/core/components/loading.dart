import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

class SBLoading extends StatelessWidget {
  const SBLoading({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoActivityIndicator();
    }

    return CircularProgressIndicator(color: accentColor);
  }
}
