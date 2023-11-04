import 'package:equatable/equatable.dart';

class ApplyPromoRequest extends Equatable {
  final String bookingId;
  final String code;

  const ApplyPromoRequest({
    required this.bookingId,
    required this.code,
  });

  @override
  List<Object?> get props => [
        bookingId,
        code,
      ];
}
