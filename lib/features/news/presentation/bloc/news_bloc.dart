import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/news_list.dart';
import '../../data/models/news.dart';
import '../../domain/usecases/get_news.dart';
import '../../domain/usecases/get_news_list.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsListUseCase _getNewsListUseCase;
  final GetNewsUseCase _getNewsUseCase;

  NewsBloc(
    this._getNewsListUseCase,
    this._getNewsUseCase,
  ) : super(const NewsLoading()) {
    on<GetNewsList>(onGetNewsList);
    on<GetNews>(onGetNews);
  }

  void onGetNewsList(
    GetNewsList event,
    Emitter<NewsState> emit,
  ) async {
    final dataState = await _getNewsListUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final news = (dataState.data!.data as List)
            .map((item) => NewsListModel.fromJson(item))
            .toList();

        emit(NewsListDone(news));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(NewsError(dataState.error!));
    }
  }

  void onGetNews(
    GetNews event,
    Emitter<NewsState> emit,
  ) async {
    final dataState = await _getNewsUseCase(params: event.id);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final news = NewsModel.fromJson(dataState.data!.data);

        emit(NewsDone(news));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(NewsError(dataState.error!));
    }
  }
}
