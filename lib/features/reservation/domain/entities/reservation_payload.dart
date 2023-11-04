import 'package:equatable/equatable.dart';

class ReservationPayload extends Equatable {
  final int? storeId;
  final String? date;
  final List<Map<String, dynamic>>? details;

  const ReservationPayload({
    this.storeId,
    this.date,
    this.details,
  });

  @override
  List<Object?> get props => [
        storeId,
        date,
        details,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'payload': {
          'store_id': storeId,
          'reservation_date': date,
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
