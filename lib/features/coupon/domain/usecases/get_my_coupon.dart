import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/coupon_repository.dart';

class GetMyCouponUseCase
    implements UseCase<DataState<ApiResponseEntity>, String> {
  final CouponRepository _couponRepository;

  GetMyCouponUseCase(this._couponRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({String? params}) {
    final id = params ?? '';

    return _couponRepository.getMyCoupon(id: id);
  }
}
