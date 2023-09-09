import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login_request.dart';
import '../repository/auth_repository.dart';

class LoginUseCase
    implements UseCase<DataState<ApiResponseEntity>, LoginRequest> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({LoginRequest? params}) {
    final loginRequest = params!;

    return _authRepository.login(
      email: loginRequest.email,
      password: loginRequest.password,
      isViaGoogle: loginRequest.isViaGoogle,
    );
  }
}
