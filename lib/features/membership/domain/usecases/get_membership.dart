import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/membership_repository.dart';

class GetMembershipUseCase
    implements UseCase<DataState<ApiResponseEntity>, void> {
  final MembershipRepository _membershipRepository;

  GetMembershipUseCase(this._membershipRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _membershipRepository.getMembership();
  }
}
