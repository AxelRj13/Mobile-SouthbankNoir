import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/profile_point_repository.dart';

class GetPointHistoryUseCase implements UseCase<DataState<ApiResponseEntity>, void> {
  final ProfilePointRepository _profilePointRepository;

  GetPointHistoryUseCase(this._profilePointRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _profilePointRepository.getPointHistory();
  }
}
