import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/point_history.dart';

abstract class PointState extends Equatable {
  final List<PointHistoryModel>? pointHistory;
  final DioException? error;

  const PointState({
    this.pointHistory,
    this.error,
  });

  @override
  List<Object> get props => [
        pointHistory!,
        error!,
      ];
}

class PointInitial extends PointState {
  const PointInitial();
}

class PointLoading extends PointState {
  const PointLoading();
}

class PointDone extends PointState {
  const PointDone({
    required List<PointHistoryModel> pointHistory,
  }) : super(
          pointHistory: pointHistory,
        );
}

class PointNotFound extends PointState {
  const PointNotFound();
}

class PointError extends PointState {
  const PointError(
    DioException error,
  ) : super(
          error: error,
        );
}
