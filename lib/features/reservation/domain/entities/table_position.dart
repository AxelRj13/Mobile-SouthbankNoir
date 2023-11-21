import 'package:equatable/equatable.dart';

class TablePosition extends Equatable {
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  const TablePosition({
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  @override
  List<Object?> get props => [
        top,
        right,
        bottom,
        left,
      ];
}
