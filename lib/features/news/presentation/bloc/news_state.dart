import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/news.dart';
import '../../data/models/news_list.dart';

abstract class NewsState extends Equatable {
  final NewsModel? news;
  final List<NewsListModel>? newsList;
  final DioException? error;

  const NewsState({
    this.news,
    this.newsList,
    this.error,
  });

  @override
  List<Object> get props => [
        news!,
        newsList!,
        error!,
      ];
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsListDone extends NewsState {
  const NewsListDone({
    required List<NewsListModel> newsList,
  }) : super(
          newsList: newsList,
        );
}

class NewsDone extends NewsState {
  const NewsDone({
    required NewsModel news,
  }) : super(
          news: news,
        );
}

class NewsNotFound extends NewsState {
  const NewsNotFound();
}

class NewsError extends NewsState {
  const NewsError(
    DioException error,
  ) : super(
          error: error,
        );
}
