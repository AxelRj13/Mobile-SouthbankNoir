abstract class ConfirmationPaymentEvent {
  const ConfirmationPaymentEvent();
}

class ConfirmPayment extends ConfirmationPaymentEvent {
  final String bookingId;

  const ConfirmPayment({
    required this.bookingId,
  });
}
