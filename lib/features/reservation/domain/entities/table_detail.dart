import 'package:equatable/equatable.dart';

class TableDetailEntity extends Equatable {
  final String? id;
  final String? tableName;
  final String? tableNo;
  final String? capacity;
  final String? downPayment;
  final int? downPaymentNumber;
  final String? minimumSpend;
  final bool? isAvailable;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  const TableDetailEntity({
    this.id,
    this.tableName,
    this.tableNo,
    this.capacity,
    this.downPayment,
    this.downPaymentNumber,
    this.minimumSpend,
    this.isAvailable,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  @override
  List<Object?> get props => [
        id,
        tableName,
        tableNo,
        capacity,
        downPayment,
        downPaymentNumber,
        minimumSpend,
        isAvailable,
        top,
        right,
        bottom,
        left,
      ];
}
