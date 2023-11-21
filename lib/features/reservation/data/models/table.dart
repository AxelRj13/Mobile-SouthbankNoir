import '../../domain/entities/table_floor.dart';
import '../../domain/entities/table.dart';
import 'table_floor.dart';

class TableModel extends TableEntity {
  const TableModel({
    String? storeId,
    String? storeName,
    String? storeImage,
    String? dateDisplay,
    String? date,
    String? event,
    List<TableFloorEntity>? floors,
  }) : super(
          storeId: storeId,
          storeName: storeName,
          storeImage: storeImage,
          dateDisplay: dateDisplay,
          date: date,
          event: event,
          floors: floors,
        );

  factory TableModel.fromJson(Map<String, dynamic> data) => TableModel(
        storeId: data['store_id'],
        storeName: data['store_name'],
        storeImage: data['store_iamge'],
        dateDisplay: data['date_display'],
        date: data['date'],
        event: data['events'],
        floors: (data['list'] as List).map((floor) => TableFloorModel.fromJson(floor)).toList(),
      );
}
