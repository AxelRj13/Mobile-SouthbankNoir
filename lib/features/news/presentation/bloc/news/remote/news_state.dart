import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/news.dart';

abstract class NewsState extends Equatable {
  final List<NewsModel>? news;
  final DioException? error;

  const NewsState({this.news, this.error});

  @override
  List<Object> get props => [news!, error!];
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsDone extends NewsState {
  const NewsDone(List<NewsModel> news) : super(news: news);
}

class NewsError extends NewsState {
  const NewsError(DioException error) : super(error: error);
}
