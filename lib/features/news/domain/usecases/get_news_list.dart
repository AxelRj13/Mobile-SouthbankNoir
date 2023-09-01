import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/news_repository.dart';

class GetNewsListUseCase
    implements UseCase<DataState<ApiResponseEntity>, void> {
  final NewsRepository _newsRepository;

  GetNewsListUseCase(this._newsRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _newsRepository.getNewsList();
  }
}
