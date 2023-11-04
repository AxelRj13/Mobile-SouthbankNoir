import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/resources/message_response.dart';
import '../../../data/models/apply_promo.dart';

abstract class ReservationPromoState extends Equatable {
  final ApplyPromoModel? applyPromo;
  final MessageResponse? message;
  final DioException? error;

  const ReservationPromoState({
    this.applyPromo,
    this.message,
    this.error,
  });

  @override
  List<Object> get props => [
        applyPromo!,
        message!,
        error!,
      ];
}

class ReservationInitial extends ReservationPromoState {
  const ReservationInitial();
}

class ReservationPromoLoading extends ReservationPromoState {
  const ReservationPromoLoading();
}

class ReservationPromo extends ReservationPromoState {
  const ReservationPromo({
    required MessageResponse message,
    ApplyPromoModel? promo,
  }) : super(
          message: message,
          applyPromo: promo,
        );
}

class ReservationPromoError extends ReservationPromoState {
  const ReservationPromoError(
    DioException error,
  ) : super(
          error: error,
        );
}
