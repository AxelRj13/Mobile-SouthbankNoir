import 'package:flutter/material.dart';

class TodayEventTitle extends StatelessWidget {
  const TodayEventTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Today\'s Event',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
