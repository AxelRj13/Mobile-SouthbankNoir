import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String? receiptRefNumber;
  final String? bookingNo;
  final String? reservationDate;
  final String? tableName;
  final String? tableCapacity;
  final String? minimumSpend;

  const PaymentEntity({
    this.receiptRefNumber,
    this.bookingNo,
    this.reservationDate,
    this.tableName,
    this.tableCapacity,
    this.minimumSpend,
  });

  @override
  List<Object?> get props => [
        receiptRefNumber,
        bookingNo,
        reservationDate,
        tableName,
        tableCapacity,
        minimumSpend,
      ];
}
