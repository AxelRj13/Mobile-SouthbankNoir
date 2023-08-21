import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../data/models/news.dart';
import '../../../../domain/usecases/get_news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNewsUseCase;

  NewsBloc(this._getNewsUseCase) : super(const NewsLoading()) {
    on<GetNews>(onGetNews);
  }

  void onGetNews(GetNews event, Emitter<NewsState> emit) async {
    final dataState = await _getNewsUseCase();

    if (dataState is DataSuccess) {
      final news = (dataState.data!.data as List)
          .map((item) => NewsModel.fromJson(item))
          .toList();

      emit(NewsDone(news));
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(NewsError(dataState.error!));
    }
  }
}
