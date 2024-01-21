import '../../../domain/entities/table_detail.dart';

abstract class ReservationEvent {
  const ReservationEvent();
}

class CreateReservation extends ReservationEvent {
  final int storeId;
  final int paymentMethod;
  final String date;
  final String personName;
  final String personPhone;
  final String notes;
  final String? promoCode;
  final List<TableDetailEntity> tables;
  final String? cardNumber;
  final String? cardMonth;
  final String? cardYear;
  final String? cardCVV;

  const CreateReservation({
    required this.storeId,
    required this.paymentMethod,
    required this.date,
    required this.personName,
    required this.personPhone,
    required this.notes,
    this.promoCode,
    required this.tables,
    this.cardNumber,
    this.cardMonth,
    this.cardYear,
    this.cardCVV,
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
