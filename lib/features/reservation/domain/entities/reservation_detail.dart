import 'package:equatable/equatable.dart';
import 'reservation_table_detail.dart';

class ReservationDetailEntity extends Equatable {
  final String? bookingId;
  final String? bookingNo;
  final String? status;
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
  final String? tableName;
  final String? tableCapacity;
  final String? createdDate;
  final String? expiryDate;
  final List<ReservationTableDetailEntity>? details;
  final String? redirectUrl;

  const ReservationDetailEntity({
    this.bookingId,
    this.bookingNo,
    this.status,
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
    this.tableName,
    this.tableCapacity,
    this.createdDate,
    this.expiryDate,
    this.details,
    this.redirectUrl,
  });

  @override
  List<Object?> get props => [
        bookingId,
        bookingNo,
        status,
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
        tableName,
        tableCapacity,
        createdDate,
        expiryDate,
        details,
        redirectUrl,
      ];
}
