import 'package:equatable/equatable.dart';

import 'table_floor.dart';

class TableEntity extends Equatable {
  final String? bookingFeature;
  final String? bookingClosedWording;
  final String? storeId;
  final String? storeName;
  final String? storeImage;
  final String? dateDisplay;
  final String? date;
  final String? event;
  final List<TableFloorEntity>? floors;

  const TableEntity({
    this.bookingFeature,
    this.bookingClosedWording,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.dateDisplay,
    this.date,
    this.event,
    this.floors,
  });

  @override
  List<Object?> get props => [
        bookingFeature,
        bookingClosedWording,
        storeId,
        storeName,
        storeImage,
        dateDisplay,
        date,
        event,
        floors,
      ];
}
