import '../../domain/entities/invoice.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    String? redirectUrl,
    String? orderId,
    String? subtotal,
    String? vaNumber,
    List<String>? atmInstructions,
    List<String>? mobileInstructions,
    List<String>? internetInstructions,
  }) : super(
          redirectUrl: redirectUrl,
          orderId: orderId,
          subtotal: subtotal,
          vaNumber: vaNumber,
          atmInstructions: atmInstructions,
          mobileInstructions: mobileInstructions,
          internetInstructions: internetInstructions,
        );

  factory InvoiceModel.fromJson(Map<String, dynamic> data) => InvoiceModel(
        redirectUrl: data['redirect_url'],
        orderId: data['order_id'],
        subtotal: data['subtotal'],
        vaNumber: data['virtualAccountNumber'],
        atmInstructions: data['payment_instruction_atm'] != null ? List<String>.from(data['payment_instruction_atm'] as List) : null,
        mobileInstructions: data['payment_instruction_mobile'] != null ? List<String>.from(data['payment_instruction_mobile'] as List) : null,
        internetInstructions: data['payment_instruction_internet'] != null ? List<String>.from(data['payment_instruction_internet'] as List) : null,
      );
}
