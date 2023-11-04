import '../../domain/entities/table_detail.dart';

class TableDetailModel extends TableDetailEntity {
  const TableDetailModel({
    String? id,
    String? tableNo,
    String? capacity,
    String? downPayment,
    int? downPaymentNumber,
    String? minimumSpend,
    bool? isAvailable,
  }) : super(
          id: id,
          tableNo: tableNo,
          capacity: capacity,
          downPayment: downPayment,
          downPaymentNumber: downPaymentNumber,
          minimumSpend: minimumSpend,
          isAvailable: isAvailable,
        );

  factory TableDetailModel.fromJson(Map<String, dynamic> data) => TableDetailModel(
        id: data['id'],
        tableNo: data['table_no'],
        capacity: data['capacity'],
        downPayment: data['down_payment'],
        downPaymentNumber: data['down_payment_number'],
        minimumSpend: data['minimum_spend'],
        isAvailable: data['is_available'] == 1,
      );
}
