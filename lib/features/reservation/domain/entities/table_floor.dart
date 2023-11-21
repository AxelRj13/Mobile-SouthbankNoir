import 'package:equatable/equatable.dart';

import 'table_group.dart';

class TableFloorEntity extends Equatable {
  final String? layout;
  final int? level;
  final List<TableGroupEntity>? table;

  const TableFloorEntity({
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
