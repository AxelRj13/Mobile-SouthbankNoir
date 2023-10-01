import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/message_response.dart';
import '../../../domain/usecases/buy_coupon.dart';
import 'coupon_purchased_event.dart';
import 'coupon_purchased_state.dart';

class CouponPurchasedBloc
    extends Bloc<CouponPurchasedEvent, CouponPurchasedState> {
  final BuyCouponUseCase _buyCouponUseCase;

  CouponPurchasedBloc(
    this._buyCouponUseCase,
  ) : super(const CouponPurchasedInitial()) {
    on<BuyCoupon>(onBuyCoupon);
  }

  void onBuyCoupon(
    BuyCoupon event,
    Emitter<CouponPurchasedState> emit,
  ) async {
    emit(const CouponPurchasedLoading());

    final dataState = await _buyCouponUseCase(params: event.couponId);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      bool responseStatus = status == 1;
      String responseTitle = 'Oppss...';
      String responseMessage = dataState.data!.message!;

      if (status == 1) {
        responseTitle = 'Thank you!';
      }

      final messageResponse = MessageResponse(
        status: responseStatus,
        title: responseTitle,
        message: responseMessage,
      );

      emit(CouponPurchased(messageResponse));
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(CouponPurchasedError(dataState.error!));
    }
  }
}
