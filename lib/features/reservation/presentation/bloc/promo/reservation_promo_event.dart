abstract class ReservationPromoEvent {
  const ReservationPromoEvent();
}

class SetApplyPromo extends ReservationPromoEvent {
  final String bookingId;
  final String code;

  const SetApplyPromo({
    required this.bookingId,
    required this.code,
  });
}
