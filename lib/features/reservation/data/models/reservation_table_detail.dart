import '../../domain/entities/reservation_table_detail.dart';

class ReservationTableDetailModel extends ReservationTableDetailEntity {
  const ReservationTableDetailModel({
    String? tableName,
    String? capacity,
    String? total,
    String? minimumSpend,
  }) : super(
          tableName: tableName,
          capacity: capacity,
          total: total,
          minimumSpend: minimumSpend,
        );

  factory ReservationTableDetailModel.fromJson(Map<String, dynamic> data) => ReservationTableDetailModel(
        tableName: data['table_name'],
        capacity: data['capacity'],
        total: data['total'],
        minimumSpend: data['minimum_spend'],
      );
}
