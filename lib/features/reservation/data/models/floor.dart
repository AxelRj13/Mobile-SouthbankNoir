import '../../domain/entities/floor.dart';
import '../../domain/entities/table.dart';
import 'table.dart';

class FloorModel extends FloorEntity {
  const FloorModel({
    String? layout,
    int? level,
    List<TableEntity>? table,
  }) : super(
          layout: layout,
          level: level,
          table: table,
        );

  factory FloorModel.fromJson(Map<String, dynamic> data) => FloorModel(
        layout: data['layout'],
        level: data['level'],
        table: (data['table'] as List).map((table) => TableModel.fromJson(table)).toList(),
      );
}
