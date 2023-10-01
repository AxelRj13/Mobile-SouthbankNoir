import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/coupon_repository.dart';

class GetCouponsUseCase implements UseCase<DataState<ApiResponseEntity>, void> {
  final CouponRepository _couponRepository;

  GetCouponsUseCase(this._couponRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _couponRepository.getCoupons();
  }
}
