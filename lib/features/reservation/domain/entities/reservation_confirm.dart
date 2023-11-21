import 'package:equatable/equatable.dart';
import 'table_detail.dart';

class ReservationConfirmEntity extends Equatable {
  final int? storeId;
  final String? storeName;
  final String? storeImage;
  final String? date;
  final String? dateDisplay;
  final String? event;
  final String? personName;
  final String? personPhone;
  final List<TableDetailEntity>? table;

  const ReservationConfirmEntity({
    this.storeId,
    this.storeName,
    this.storeImage,
    this.date,
    this.dateDisplay,
    this.event,
    this.personName,
    this.personPhone,
    this.table,
  });

  @override
  List<Object?> get props => [
        storeId,
        storeName,
        storeImage,
        date,
        dateDisplay,
        event,
        personName,
        personPhone,
        table,
      ];
}
