import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/register_request.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase implements UseCase<DataState<ApiResponseEntity>, RegisterRequest> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({RegisterRequest? params}) {
    final registerRequest = params!;

    return _authRepository.register(
      firstName: registerRequest.firstName,
      lastName: registerRequest.lastName,
      dob: registerRequest.dob,
      city: registerRequest.city,
      email: registerRequest.email,
      phone: registerRequest.phone,
      password: registerRequest.password,
      confirmPassword: registerRequest.confirmPassword,
    );
  }
}
