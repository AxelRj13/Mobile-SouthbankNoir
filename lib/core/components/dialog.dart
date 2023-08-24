import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

Future<void> popupDialog(BuildContext context, String image) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}

Future<void> comingsoonDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Center(
          child: Text(
            'Coming Soon!',
            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
          ),
        ),
        content: const Text(
          'This feature is coming soon, stay tuned.',
        ),
      );
    },
  );
}
