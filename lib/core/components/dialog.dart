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
        content: const Text('This feature is coming soon, stay tuned.'),
      );
    },
  );
}

Future<void> exceptionDialog(BuildContext context) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Center(
          child: Text(
            'Oppss...',
            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
          ),
        ),
        content: const Text(
            'There is an error occurred. Please try again or contact our crew.'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: accentColor),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

Future<void> basicDialog(BuildContext context, String title, String message) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Center(
          child: Text(
            title,
            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: accentColor),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}
