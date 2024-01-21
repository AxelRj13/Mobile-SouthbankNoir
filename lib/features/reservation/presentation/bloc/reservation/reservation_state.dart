import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/resources/message_response.dart';
import '../../../data/models/apply_promo.dart';
import '../../../data/models/reservation.dart';
import '../../../data/models/reservation_detail.dart';

abstract class ReservationState extends Equatable {
  final String? bookingId;
  final String? redirectUrl;
  final ApplyPromoModel? applyPromo;
  final List<ReservationModel>? reservations;
  final ReservationDetailModel? reservationDetailModel;
  final MessageResponse? message;
  final DioException? error;

  const ReservationState({
    this.bookingId,
    this.redirectUrl,
    this.applyPromo,
    this.reservations,
    this.reservationDetailModel,
    this.message,
    this.error,
  });

  @override
  List<Object> get props => [
        bookingId!,
        redirectUrl!,
        applyPromo!,
        reservations!,
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
    String? redirectUrl,
  }) : super(
          message: message,
          bookingId: bookingId,
          redirectUrl: redirectUrl,
        );
}

class ReservationDone extends ReservationState {
  const ReservationDone(
    List<ReservationModel> reservations,
  ) : super(
          reservations: reservations,
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
