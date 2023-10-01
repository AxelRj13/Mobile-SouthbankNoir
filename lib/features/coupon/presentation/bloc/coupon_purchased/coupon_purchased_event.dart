abstract class CouponPurchasedEvent {
  const CouponPurchasedEvent();
}

class BuyCoupon extends CouponPurchasedEvent {
  final String couponId;

  const BuyCoupon({required this.couponId});
}
