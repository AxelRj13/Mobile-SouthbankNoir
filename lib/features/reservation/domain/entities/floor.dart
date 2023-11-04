import 'package:equatable/equatable.dart';

import 'table.dart';

class FloorEntity extends Equatable {
  final String? layout;
  final int? level;
  final List<TableEntity>? table;

  const FloorEntity({
    this.layout,
    this.level,
    this.table,
  });

  @override
  List<Object?> get props => [
        layout,
        level,
        table,
      ];
}
