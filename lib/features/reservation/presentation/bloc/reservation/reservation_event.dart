import '../../../domain/entities/table_detail.dart';

abstract class ReservationEvent {
  const ReservationEvent();
}

class CreateReservation extends ReservationEvent {
  final int storeId;
  final String date;
  final String personName;
  final String personPhone;
  final String notes;
  final String? promoCode;
  final List<TableDetailEntity> tables;

  const CreateReservation({
    required this.storeId,
    required this.date,
    required this.personName,
    required this.personPhone,
    required this.notes,
    this.promoCode,
    required this.tables,
  });
}

class GetReservations extends ReservationEvent {
  const GetReservations();
}

class GetReservationDetail extends ReservationEvent {
  final String bookingId;

  const GetReservationDetail({
    required this.bookingId,
  });
}
