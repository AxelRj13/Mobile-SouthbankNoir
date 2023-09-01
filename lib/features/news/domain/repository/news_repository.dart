import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class NewsRepository {
  Future<DataState<ApiResponseEntity>> getNewsList();

  Future<DataState<ApiResponseEntity>> getNews({
    required String id,
  });
}
