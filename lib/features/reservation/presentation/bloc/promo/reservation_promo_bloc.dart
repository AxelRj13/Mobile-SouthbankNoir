import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/message_response.dart';
import '../../../data/models/apply_promo.dart';
import '../../../domain/entities/apply_promo_request.dart';
import '../../../domain/usecases/apply_promo.dart';
import 'reservation_promo_event.dart';
import 'reservation_promo_state.dart';

class ReservationPromoBloc extends Bloc<ReservationPromoEvent, ReservationPromoState> {
  final ApplyPromoUseCase _applyPromoUseCase;

  ReservationPromoBloc(
    this._applyPromoUseCase,
  ) : super(const ReservationInitial()) {
    on<SetApplyPromo>(onApplyPromo);
  }

  void onApplyPromo(
    SetApplyPromo event,
    Emitter<ReservationPromoState> emit,
  ) async {
    emit(const ReservationPromoLoading());

    final applyPromoRequest = ApplyPromoRequest(
      storeId: event.storeId,
      subtotal: event.subtotal,
      code: event.code,
    );

    final dataState = await _applyPromoUseCase(
      params: applyPromoRequest,
    );

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      bool responseStatus = status == 1;
      String responseTitle = 'Oppss...';
      String responseMessage = dataState.data!.message!;

      if (status == 1) {
        responseTitle = 'Apply promo success!';
      }

      final messageResponse = MessageResponse(
        status: responseStatus,
        title: responseTitle,
        message: responseMessage,
      );

      if (status == 1) {
        final applyPromo = ApplyPromoModel.fromJson(
          dataState.data!.data,
        );

        emit(
          ReservationPromo(
            message: messageResponse,
            promo: applyPromo,
            promoApplied: true,
          ),
        );
      } else {
        emit(
          ReservationPromo(
            message: messageResponse,
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(ReservationPromoError(dataState.error!));
    }
  }
}
