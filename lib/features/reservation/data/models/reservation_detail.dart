import '../../domain/entities/reservation_detail.dart';
import '../../domain/entities/reservation_table_detail.dart';
import 'reservation_table_detail.dart';

class ReservationDetailModel extends ReservationDetailEntity {
  const ReservationDetailModel({
    String? bookingId,
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
    List<ReservationTableDetailEntity>? details,
  }) : super(
          bookingId: bookingId,
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
          details: details,
        );

  factory ReservationDetailModel.fromJson(Map<String, dynamic> data) => ReservationDetailModel(
        bookingId: data['booking_id'],
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
        details: (data['details'] as List).map((table) => ReservationTableDetailModel.fromJson(table)).toList(),
      );
}
