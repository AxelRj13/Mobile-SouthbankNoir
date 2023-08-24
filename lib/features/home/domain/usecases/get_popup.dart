import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/popup_repository.dart';

class GetPopupUseCase implements UseCase<DataState<ApiResponseEntity>, void> {
  final PopupRepository _popupRepository;

  GetPopupUseCase(this._popupRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _popupRepository.getPopup();
  }
}
