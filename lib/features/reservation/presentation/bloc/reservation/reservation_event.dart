import '../../../domain/entities/table_detail.dart';

abstract class ReservationEvent {
  const ReservationEvent();
}

class CreateReservation extends ReservationEvent {
  final int storeId;
  final String date;
  final TableDetailEntity table;

  const CreateReservation({
    required this.storeId,
    required this.date,
    required this.table,
  });
}

class GetReservationDetail extends ReservationEvent {
  final String bookingId;

  const GetReservationDetail({
    required this.bookingId,
  });
}
