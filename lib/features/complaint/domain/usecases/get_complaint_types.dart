import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/complaint_repository.dart';

class GetComplaintTypesUseCase
    implements UseCase<DataState<ApiResponseEntity>, void> {
  final ComplaintRepository _complaintRepository;

  GetComplaintTypesUseCase(this._complaintRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _complaintRepository.getTypes();
  }
}
