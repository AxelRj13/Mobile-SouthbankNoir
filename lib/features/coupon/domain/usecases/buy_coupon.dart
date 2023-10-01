import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/coupon_repository.dart';

class BuyCouponUseCase
    implements UseCase<DataState<ApiResponseEntity>, String> {
  final CouponRepository _couponRepository;

  BuyCouponUseCase(this._couponRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({String? params}) {
    final couponId = params!;

    return _couponRepository.buyCoupon(couponId: couponId);
  }
}
