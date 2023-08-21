import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/news_repository.dart';

class GetNewsUseCase implements UseCase<DataState<ApiResponseEntity>, void> {
  final NewsRepository _newsRepository;

  GetNewsUseCase(this._newsRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _newsRepository.getNews();
  }
}
