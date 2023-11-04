import 'package:equatable/equatable.dart';

import 'table_detail.dart';

class TableEntity extends Equatable {
  final String? name;
  final List<TableDetailEntity>? tables;

  const TableEntity({
    this.name,
    this.tables,
  });

  @override
  List<Object?> get props => [
        name,
        tables,
      ];
}
