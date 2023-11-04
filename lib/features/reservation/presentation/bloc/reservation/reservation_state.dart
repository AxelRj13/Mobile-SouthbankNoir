import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/resources/message_response.dart';
import '../../../data/models/apply_promo.dart';
import '../../../data/models/reservation_detail.dart';

abstract class ReservationState extends Equatable {
  final String? bookingId;
  final ApplyPromoModel? applyPromo;
  final ReservationDetailModel? reservationDetailModel;
  final MessageResponse? message;
  final DioException? error;

  const ReservationState({
    this.bookingId,
    this.applyPromo,
    this.reservationDetailModel,
    this.message,
    this.error,
  });

  @override
  List<Object> get props => [
        bookingId!,
        applyPromo!,
        reservationDetailModel!,
        message!,
        error!,
      ];
}

class ReservationInitial extends ReservationState {
  const ReservationInitial();
}

class ReservationLoading extends ReservationState {
  const ReservationLoading();
}

class ReservationBook extends ReservationState {
  const ReservationBook({
    required MessageResponse message,
    String? bookingId,
  }) : super(
          message: message,
          bookingId: bookingId,
        );
}

class ReservationDetail extends ReservationState {
  const ReservationDetail(
    ReservationDetailModel reservationDetailModel,
  ) : super(
          reservationDetailModel: reservationDetailModel,
        );
}

class ReservationError extends ReservationState {
  const ReservationError(
    DioException error,
  ) : super(
          error: error,
        );
}
