import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login_request.dart';
import '../repository/login_repository.dart';

class LoginUseCase
    implements UseCase<DataState<ApiResponseEntity>, LoginRequest> {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({LoginRequest? params}) {
    final loginRequest = params!;

    return _loginRepository.login(
      email: loginRequest.email,
      password: loginRequest.password,
    );
  }
}
