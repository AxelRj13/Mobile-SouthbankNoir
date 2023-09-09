import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class CheckEmailUseCase
    implements UseCase<DataState<ApiResponseEntity>, String> {
  final AuthRepository _authRepository;

  CheckEmailUseCase(this._authRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({String? params}) {
    return _authRepository.checkEmail(
      email: params!,
    );
  }
}
