import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile_request.dart';
import '../repository/profile_repository.dart';

class UpdateProfileUseCase implements UseCase<DataState<ApiResponseEntity>, ProfileRequest> {
  final ProfileRepository _profileRepository;

  UpdateProfileUseCase(this._profileRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({ProfileRequest? params}) {
    final profileRequest = params!;

    return _profileRepository.updateProfile(
      firstName: profileRequest.firstName,
      lastName: profileRequest.lastName,
      email: profileRequest.email,
      phone: profileRequest.phone,
      dob: profileRequest.dob,
      city: profileRequest.city,
      file: profileRequest.file,
    );
  }
}
