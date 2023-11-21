import '../../domain/entities/payment.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    String? receiptRefNumber,
    String? bookingNo,
    String? reservationDate,
    String? tableName,
    String? tableCapacity,
    String? minimumSpend,
  }) : super(
          receiptRefNumber: receiptRefNumber,
          bookingNo: bookingNo,
          reservationDate: reservationDate,
          tableName: tableName,
          tableCapacity: tableCapacity,
          minimumSpend: minimumSpend,
        );

  factory PaymentModel.fromJson(Map<String, dynamic> data) => PaymentModel(
        receiptRefNumber: data['receipt_ref_number'],
        bookingNo: data['booking_no'],
        reservationDate: data['reservation_date'],
        tableName: data['table_name'],
        tableCapacity: data['table_capacity'],
        minimumSpend: data['minimum_spend'],
      );
}
