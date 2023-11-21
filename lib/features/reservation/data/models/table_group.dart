import '../../domain/entities/table_group.dart';
import '../../domain/entities/table_detail.dart';
import 'table_detail.dart';

class TableModel extends TableGroupEntity {
  const TableModel({
    String? name,
    List<TableDetailEntity>? tables,
  }) : super(
          name: name,
          tables: tables,
        );

  factory TableModel.fromJson(Map<String, dynamic> data) => TableModel(
        name: data['name'],
        tables: (data['tables'] as List).map((table) => TableDetailModel.fromJson(table)).toList(),
      );
}
