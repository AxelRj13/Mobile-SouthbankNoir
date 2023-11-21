import 'package:equatable/equatable.dart';
import 'reservation_detail.dart';

class ReservationEntity extends Equatable {
  final String? date;
  final List<ReservationDetailEntity>? bookings;

  const ReservationEntity({
    this.date,
    this.bookings,
  });

  @override
  List<Object?> get props => [
        date,
        bookings,
      ];
}
