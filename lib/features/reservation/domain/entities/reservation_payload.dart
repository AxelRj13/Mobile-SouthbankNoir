import 'package:equatable/equatable.dart';

class ReservationPayload extends Equatable {
  final int? storeId;
  final String? date;
  final String? personName;
  final String? personPhone;
  final String? notes;
  final String? promoCode;
  final List<Map<String, dynamic>>? details;

  const ReservationPayload({
    this.storeId,
    this.date,
    this.personName,
    this.personPhone,
    this.notes,
    this.promoCode,
    this.details,
  });

  @override
  List<Object?> get props => [
        storeId,
        date,
        personName,
        personPhone,
        notes,
        promoCode,
        details,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'payload': {
          'store_id': storeId,
          'reservation_date': date,
          'contact_person_name': personName,
          'contact_person_phone': personPhone,
          'notes': notes,
          'promo_code': promoCode,
          'details': details,
        },
      };
}

class ReservationTablePayload extends Equatable {
  final int? id;
  final int? total;

  const ReservationTablePayload({
    this.id,
    this.total,
  });

  @override
  List<Object?> get props => [
        id,
        total,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'table_id': id,
        'total': total,
      };
}
