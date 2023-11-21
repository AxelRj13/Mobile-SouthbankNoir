import '../../domain/entities/table_floor.dart';
import '../../domain/entities/table_group.dart';
import 'table_group.dart';

class TableFloorModel extends TableFloorEntity {
  const TableFloorModel({
    String? layout,
    int? level,
    List<TableGroupEntity>? table,
  }) : super(
          layout: layout,
          level: level,
          table: table,
        );

  factory TableFloorModel.fromJson(Map<String, dynamic> data) => TableFloorModel(
        layout: data['layout'],
        level: data['level'],
        table: (data['table'] as List).map((table) => TableModel.fromJson(table)).toList(),
      );
}
