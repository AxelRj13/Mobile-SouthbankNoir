import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/coupon.dart';
import '../../../data/models/coupon_list.dart';

abstract class CouponState extends Equatable {
  final int? points;
  final CouponModel? coupon;
  final List<CouponListModel>? coupons;
  final List<CouponListModel>? myCoupons;
  final DioException? error;

  const CouponState({
    this.points,
    this.coupon,
    this.coupons,
    this.myCoupons,
    this.error,
  });

  @override
  List<Object> get props => [
        points!,
        coupon!,
        coupons!,
        myCoupons!,
        error!,
      ];
}

class CouponInitial extends CouponState {
  const CouponInitial();
}

class CouponLoading extends CouponState {
  const CouponLoading();
}

class CouponsDone extends CouponState {
  const CouponsDone(
    int points,
    List<CouponListModel>? coupons,
    List<CouponListModel>? myCoupons,
  ) : super(
          points: points,
          coupons: coupons,
          myCoupons: myCoupons,
        );
}

class CouponDone extends CouponState {
  const CouponDone(CouponModel coupon) : super(coupon: coupon);
}

class CouponNotFound extends CouponState {
  const CouponNotFound();
}

class CouponError extends CouponState {
  const CouponError(DioException error) : super(error: error);
}
