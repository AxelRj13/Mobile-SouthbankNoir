import '../../domain/entities/floor.dart';
import '../../domain/entities/reservation.dart';
import 'floor.dart';

class ReservationModel extends ReservationEntity {
  const ReservationModel({
    String? storeId,
    String? storeName,
    String? dateDisplay,
    String? date,
    List<FloorEntity>? floors,
  }) : super(
          storeId: storeId,
          storeName: storeName,
          dateDisplay: dateDisplay,
          date: date,
          floors: floors,
        );

  factory ReservationModel.fromJson(Map<String, dynamic> data) => ReservationModel(
        storeId: data['store_id'],
        storeName: data['store_name'],
        dateDisplay: data['date_display'],
        date: data['date'],
        floors: (data['list'] as List).map((floor) => FloorModel.fromJson(floor)).toList(),
      );
}
