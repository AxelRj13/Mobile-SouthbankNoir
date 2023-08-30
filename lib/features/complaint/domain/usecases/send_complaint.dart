import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/complaint_request.dart';
import '../repository/complaint_repository.dart';

class SendComplaintUseCase
    implements UseCase<DataState<ApiResponseEntity>, ComplaintRequest> {
  final ComplaintRepository _complaintRepository;

  SendComplaintUseCase(this._complaintRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({ComplaintRequest? params}) {
    final complaintRequest = params!;

    return _complaintRepository.sendComplaint(
      type: complaintRequest.type,
      date: complaintRequest.date,
      store: complaintRequest.store,
      description: complaintRequest.description,
    );
  }
}
