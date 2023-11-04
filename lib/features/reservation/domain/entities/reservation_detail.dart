import 'package:equatable/equatable.dart';
import 'reservation_table_detail.dart';

class ReservationDetailEntity extends Equatable {
  final String? bookingId;
  final String? storeImage;
  final String? storeName;
  final String? events;
  final String? reservationDate;
  final String? contactPersonName;
  final String? contactPersonPhone;
  final String? notes;
  final String? qty;
  final String? promoCode;
  final String? totalDiscount;
  final String? totalPayment;
  final List<ReservationTableDetailEntity>? details;

  const ReservationDetailEntity({
    this.bookingId,
    this.storeImage,
    this.storeName,
    this.events,
    this.reservationDate,
    this.contactPersonName,
    this.contactPersonPhone,
    this.notes,
    this.qty,
    this.promoCode,
    this.totalDiscount,
    this.totalPayment,
    this.details,
  });

  @override
  List<Object?> get props => [
        bookingId,
        storeImage,
        storeName,
        events,
        reservationDate,
        contactPersonName,
        contactPersonPhone,
        notes,
        qty,
        promoCode,
        totalDiscount,
        totalPayment,
        details,
      ];
}
