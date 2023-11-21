import 'package:equatable/equatable.dart';

import 'table_floor.dart';

class TableEntity extends Equatable {
  final String? storeId;
  final String? storeName;
  final String? storeImage;
  final String? dateDisplay;
  final String? date;
  final String? event;
  final List<TableFloorEntity>? floors;

  const TableEntity({
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
        storeId,
        storeName,
        storeImage,
        dateDisplay,
        date,
        event,
        floors,
      ];
}
