import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/point_history.dart';
import '../../../domain/usecases/get_point_history.dart';
import 'point_event.dart';
import 'point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  final GetPointHistoryUseCase _getPointHistoryUseCase;

  PointBloc(this._getPointHistoryUseCase) : super(const PointInitial()) {
    on<GetPointHistory>(onGetPointHistory);
  }

  void onGetPointHistory(
    GetPointHistory event,
    Emitter<PointState> emit,
  ) async {
    emit(const PointLoading());

    final dataState = await _getPointHistoryUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final pointHistory = (dataState.data!.data as List)
            .map(
              (item) => PointHistoryModel.fromJson(item),
            )
            .toList();

        print(pointHistory);

        emit(
          PointDone(pointHistory: pointHistory),
        );
      } else {
        emit(const PointNotFound());
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(PointError(dataState.error!));
    }
  }
}
