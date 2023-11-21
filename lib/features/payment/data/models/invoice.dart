import '../../domain/entities/invoice.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    String? orderId,
    String? subtotal,
    String? vaNumber,
    List<String>? atmInstructions,
    List<String>? mobileInstructions,
    List<String>? internetInstructions,
  }) : super(
          orderId: orderId,
          subtotal: subtotal,
          vaNumber: vaNumber,
          atmInstructions: atmInstructions,
          mobileInstructions: mobileInstructions,
          internetInstructions: internetInstructions,
        );

  factory InvoiceModel.fromJson(Map<String, dynamic> data) => InvoiceModel(
        orderId: data['order_id'],
        subtotal: data['subtotal'],
        vaNumber: data['virtualAccountNumber'],
        atmInstructions: List<String>.from(data['payment_instruction_atm'] as List),
        mobileInstructions: List<String>.from(data['payment_instruction_mobile'] as List),
        internetInstructions: List<String>.from(data['payment_instruction_internet'] as List),
      );
}
