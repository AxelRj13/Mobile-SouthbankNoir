abstract class CouponEvent {
  const CouponEvent();
}

class GetCoupons extends CouponEvent {
  const GetCoupons();
}

class GetCoupon extends CouponEvent {
  final String id;

  const GetCoupon({required this.id});
}

class GetMyCoupon extends CouponEvent {
  final String id;

  const GetMyCoupon({required this.id});
}
