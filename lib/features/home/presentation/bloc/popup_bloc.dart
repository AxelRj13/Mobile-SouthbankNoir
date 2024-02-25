import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/popup.dart';
import '../../domain/usecases/get_popup.dart';
import 'popup_event.dart';
import 'popup_state.dart';

class PopupBloc extends Bloc<PopupEvent, PopupState> {
  final GetPopupUseCase _getPopupUseCase;

  PopupBloc(this._getPopupUseCase) : super(const PopupLoading()) {
    on<GetPopup>(onGetPopup);
  }

  void onGetPopup(
    GetPopup popup,
    Emitter<PopupState> emit,
  ) async {
    final dataState = await _getPopupUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final popups = (dataState.data!.data as List).map((item) => PopupModel.fromJson(item)).toList();

        final popup = popups.first;

        emit(PopupDone(popup: popup));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
    }
  }
}
