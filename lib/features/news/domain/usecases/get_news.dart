import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/news_repository.dart';

class GetNewsUseCase implements UseCase<DataState<ApiResponseEntity>, String> {
  final NewsRepository _newsRepository;

  GetNewsUseCase(this._newsRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({String? params}) {
    final id = params!;
    return _newsRepository.getNews(id: id);
  }
}
