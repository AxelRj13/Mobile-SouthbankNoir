import 'package:equatable/equatable.dart';

import 'table_detail.dart';

class TableGroupEntity extends Equatable {
  final String? name;
  final List<TableDetailEntity>? tables;

  const TableGroupEntity({
    this.name,
    this.tables,
  });

  @override
  List<Object?> get props => [
        name,
        tables,
      ];
}
