import 'package:equatable/equatable.dart';

class InvoiceEntity extends Equatable {
  final String? orderId;
  final String? subtotal;
  final String? vaNumber;
  final List<String>? atmInstructions;
  final List<String>? mobileInstructions;
  final List<String>? internetInstructions;

  const InvoiceEntity({
    this.orderId,
    this.subtotal,
    this.vaNumber,
    this.atmInstructions,
    this.mobileInstructions,
    this.internetInstructions,
  });

  @override
  List<Object?> get props => [
        orderId,
        subtotal,
        vaNumber,
        atmInstructions,
        mobileInstructions,
        internetInstructions,
      ];
}
