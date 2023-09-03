import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/promo_repository.dart';

class GetPromoListUseCase
    implements UseCase<DataState<ApiResponseEntity>, void> {
  final PromoRepository _promoRepository;

  GetPromoListUseCase(this._promoRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _promoRepository.getPromoList();
  }
}
