import 'package:equatable/equatable.dart';

import 'floor.dart';

class ReservationEntity extends Equatable {
  final String? storeId;
  final String? storeName;
  final String? dateDisplay;
  final String? date;
  final List<FloorEntity>? floors;

  const ReservationEntity({
    this.storeId,
    this.storeName,
    this.dateDisplay,
    this.date,
    this.floors,
  });

  @override
  List<Object?> get props => [
        storeId,
        storeName,
        dateDisplay,
        date,
        floors,
      ];
}
