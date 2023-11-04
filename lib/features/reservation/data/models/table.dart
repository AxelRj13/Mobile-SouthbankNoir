import '../../domain/entities/table.dart';
import '../../domain/entities/table_detail.dart';
import 'table_detail.dart';

class TableModel extends TableEntity {
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
