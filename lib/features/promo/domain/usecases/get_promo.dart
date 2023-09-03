import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/promo_repository.dart';

class GetPromoUseCase implements UseCase<DataState<ApiResponseEntity>, String> {
  final PromoRepository _promoRepository;

  GetPromoUseCase(this._promoRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({String? params}) {
    final id = params!;
    return _promoRepository.getPromo(id: id);
  }
}
