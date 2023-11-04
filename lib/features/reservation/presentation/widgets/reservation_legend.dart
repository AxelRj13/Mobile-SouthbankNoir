import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/legend.dart';

class ReservationLegend extends StatelessWidget {
  ReservationLegend({super.key});

  final List<Legend> _legends = [
    const Legend(label: 'Available', color: Colors.grey),
    const Legend(label: 'Booked', color: Colors.green),
    Legend(label: 'Selected', color: accentColor),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _legends
          .map(
            (legend) => Row(
              children: [
                CircleAvatar(
                  radius: 8.0,
                  backgroundColor: legend.color,
                ),
                const SizedBox(width: 5.0),
                Text(legend.label),
              ],
            ),
          )
          .toList(),
    );
  }
}
