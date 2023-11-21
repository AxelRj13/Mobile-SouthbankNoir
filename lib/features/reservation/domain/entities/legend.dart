import 'dart:ui';

import 'package:equatable/equatable.dart';

class Legend extends Equatable {
  final String label;
  final Color color;

  const Legend({
    required this.label,
    required this.color,
  });

  @override
  List<Object?> get props => [
        label,
        color,
      ];
}
