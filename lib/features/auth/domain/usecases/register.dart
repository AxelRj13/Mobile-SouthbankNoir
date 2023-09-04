import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/register_request.dart';
import '../repository/register_repository.dart';

class RegisterUseCase
    implements UseCase<DataState<ApiResponseEntity>, RegisterRequest> {
  final RegisterRepository _registerRepository;

  RegisterUseCase(this._registerRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({RegisterRequest? params}) {
    final registerRequest = params!;

    return _registerRepository.register(
      firstName: registerRequest.firstName,
      lastName: registerRequest.lastName,
      dob: registerRequest.dob,
      city: registerRequest.city,
      gender: registerRequest.gender,
      email: registerRequest.email,
      phone: registerRequest.phone,
      password: registerRequest.password,
      confirmPassword: registerRequest.confirmPassword,
    );
  }
}
