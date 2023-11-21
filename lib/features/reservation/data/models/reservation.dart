import '../../domain/entities/reservation.dart';
import '../../domain/entities/reservation_detail.dart';
import 'reservation_detail.dart';

class ReservationModel extends ReservationEntity {
  const ReservationModel({
    String? date,
    List<ReservationDetailEntity>? bookings,
  }) : super(
          date: date,
          bookings: bookings,
        );

  factory ReservationModel.fromJson(Map<String, dynamic> data) => ReservationModel(
        date: data['date'],
        bookings: (data['bookings'] as List).map((booking) => ReservationDetailModel.fromJson(booking)).toList(),
      );
}
