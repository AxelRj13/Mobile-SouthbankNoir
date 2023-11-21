import '../../domain/entities/reservation_detail.dart';
import '../../domain/entities/reservation_table_detail.dart';
import 'reservation_table_detail.dart';

class ReservationDetailModel extends ReservationDetailEntity {
  const ReservationDetailModel({
    String? bookingId,
    String? bookingNo,
    String? status,
    String? storeImage,
    String? storeName,
    String? events,
    String? reservationDate,
    String? contactPersonName,
    String? contactPersonPhone,
    String? notes,
    String? qty,
    String? promoCode,
    String? totalDiscount,
    String? totalPayment,
    String? tableName,
    String? tableCapacity,
    List<ReservationTableDetailEntity>? details,
  }) : super(
          bookingId: bookingId,
          bookingNo: bookingNo,
          status: status,
          storeImage: storeImage,
          storeName: storeName,
          events: events,
          reservationDate: reservationDate,
          contactPersonName: contactPersonName,
          contactPersonPhone: contactPersonPhone,
          notes: notes,
          qty: qty,
          promoCode: promoCode,
          totalDiscount: totalDiscount,
          totalPayment: totalPayment,
          tableName: tableName,
          tableCapacity: tableCapacity,
          details: details,
        );

  factory ReservationDetailModel.fromJson(Map<String, dynamic> data) => ReservationDetailModel(
        bookingId: data['booking_id'],
        bookingNo: data['booking_no'],
        status: data['status'],
        storeImage: data['store_image'],
        storeName: data['store_name'],
        events: data['events'],
        reservationDate: data['reservation_date'],
        contactPersonName: data['contact_person_name'],
        contactPersonPhone: data['contact_person_phone'],
        notes: data['notes'],
        qty: data['qty'],
        promoCode: data['promo_code'],
        totalDiscount: data['total_discount'],
        totalPayment: data['total_payment'],
        tableName: data['table_name'],
        tableCapacity: data['table_capacity'],
        details: data['details'] != null ? (data['details'] as List).map((table) => ReservationTableDetailModel.fromJson(table)).toList() : null,
      );
}
