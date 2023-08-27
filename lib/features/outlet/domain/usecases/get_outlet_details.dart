import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/outlet_repository.dart';

class GetOutletDetailsUseCase
    implements UseCase<DataState<ApiResponseEntity>, void> {
  final OutletRepository _outletRepository;

  GetOutletDetailsUseCase(this._outletRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _outletRepository.getOutletDetails();
  }
}
