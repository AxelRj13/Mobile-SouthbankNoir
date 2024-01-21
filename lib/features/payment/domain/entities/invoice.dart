import 'package:equatable/equatable.dart';

class InvoiceEntity extends Equatable {
  final String? redirectUrl;
  final String? orderId;
  final String? subtotal;
  final String? vaNumber;
  final List<String>? atmInstructions;
  final List<String>? mobileInstructions;
  final List<String>? internetInstructions;

  const InvoiceEntity({
    this.redirectUrl,
    this.orderId,
    this.subtotal,
    this.vaNumber,
    this.atmInstructions,
    this.mobileInstructions,
    this.internetInstructions,
  });

  @override
  List<Object?> get props => [
        redirectUrl,
        orderId,
        subtotal,
        vaNumber,
        atmInstructions,
        mobileInstructions,
        internetInstructions,
      ];
}
