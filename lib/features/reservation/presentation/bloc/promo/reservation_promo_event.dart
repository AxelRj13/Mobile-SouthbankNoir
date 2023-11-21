abstract class ReservationPromoEvent {
  const ReservationPromoEvent();
}

class SetApplyPromo extends ReservationPromoEvent {
  final String storeId;
  final String subtotal;
  final String code;

  const SetApplyPromo({
    required this.storeId,
    required this.subtotal,
    required this.code,
  });
}
