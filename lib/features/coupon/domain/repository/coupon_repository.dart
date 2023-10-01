import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class CouponRepository {
  Future<DataState<ApiResponseEntity>> getCoupons();

  Future<DataState<ApiResponseEntity>> getCoupon({
    required String id,
  });

  Future<DataState<ApiResponseEntity>> getMyCoupon({
    required String id,
  });

  Future<DataState<ApiResponseEntity>> buyCoupon({
    required String couponId,
  });
}
