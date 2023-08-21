import 'package:flutter/material.dart';
import 'package:southbank/config/theme/app_theme.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  final List<int> steps = [1, 2, 3];
  final List<String> labels = ['Basic', 'VIP', 'Priority'];

  List<Icon> _buildStepIndicator() {
    return [
      for (var step in steps)
        Icon(
          Icons.circle,
          color: step == 1 ? Colors.redAccent[400] : Colors.grey,
          size: 24.0,
        ),
    ];
  }

  List<Text> _buildStepLabel() {
    return [
      for (var label in labels)
        Text(
          label,
          style: TextStyle(color: accentColor),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: accentColor),
            ),
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: LinearProgressIndicator(
                value: 0.7,
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                backgroundColor: backgroundColor,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildStepIndicator(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildStepLabel(),
              )
            ],
          )
        ],
      ),
    );
  }
}
