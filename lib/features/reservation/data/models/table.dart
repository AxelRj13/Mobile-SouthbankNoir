import '../../domain/entities/table_floor.dart';
import '../../domain/entities/table.dart';
import 'table_floor.dart';

class TableModel extends TableEntity {
  const TableModel({
    String? bookingFeature,
    String? bookingClosedWording,
    String? storeId,
    String? storeName,
    String? storeImage,
    String? dateDisplay,
    String? date,
    String? event,
    List<TableFloorEntity>? floors,
  }) : super(
          bookingFeature: bookingFeature,
          bookingClosedWording: bookingClosedWording,
          storeId: storeId,
          storeName: storeName,
          storeImage: storeImage,
          dateDisplay: dateDisplay,
          date: date,
          event: event,
          floors: floors,
        );

  factory TableModel.fromJson(Map<String, dynamic> data) => TableModel(
        bookingFeature: data['booking_feature'],
        bookingClosedWording: data['booking_closed_wording'],
        storeId: data['store_id'],
        storeName: data['store_name'],
        storeImage: data['store_iamge'],
        dateDisplay: data['date_display'],
        date: data['date'],
        event: data['events'],
        floors: (data['list'] as List).map((floor) => TableFloorModel.fromJson(floor)).toList(),
      );
}
