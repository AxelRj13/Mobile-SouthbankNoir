abstract class PaymentEvent {
  const PaymentEvent();
}

class GetPayment extends PaymentEvent {
  final String bookingId;

  const GetPayment({
    required this.bookingId,
  });
}
