import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/message_response.dart';
import '../../../data/models/reservation_detail.dart';
import '../../../data/models/reservation.dart';
import '../../../domain/usecases/get_reservations.dart';
import '../../../domain/entities/reservation_payload.dart';
import '../../../domain/usecases/create_reservation.dart';
import '../../../domain/usecases/get_reservation_detail.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final CreateReservationUseCase _createReservationUseCase;
  final GetReservationsUseCase _getReservationsUseCase;
  final GetReservationDetailUseCase _getReservationDetailUseCase;

  ReservationBloc(
    this._createReservationUseCase,
    this._getReservationsUseCase,
    this._getReservationDetailUseCase,
  ) : super(const ReservationInitial()) {
    on<CreateReservation>(onReservationCreate);
    on<GetReservations>(onGetReservations);
    on<GetReservationDetail>(onGetReservationDetail);
  }

  void onReservationCreate(
    CreateReservation event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const ReservationLoading());

    final tables = event.tables
        .map(
          (table) => ReservationTablePayload(
            id: int.parse(table.id!),
            total: table.downPaymentNumber,
          ).toJson(),
        )
        .toList();

    final reservationPayload = ReservationPayload(
      storeId: event.storeId,
      paymentMethod: event.paymentMethod,
      date: event.date,
      personName: event.personName,
      personPhone: event.personPhone,
      notes: event.notes,
      promoCode: event.promoCode,
      details: tables,
    ).toJson();

    if (event.paymentMethod == 8) {
      reservationPayload['payload']['card_number'] = event.cardNumber;
      reservationPayload['payload']['card_exp_month'] = event.cardMonth;
      reservationPayload['payload']['card_exp_year'] = event.cardYear;
      reservationPayload['payload']['card_cvv'] = event.cardCVV;
    }

    final dataState = await _createReservationUseCase(
      params: reservationPayload,
    );

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      bool responseStatus = status == 1;
      String responseTitle = 'Oppss...';
      String responseMessage = dataState.data!.message!;

      if (status == 1) {
        responseTitle = 'Reservation success!';
      }

      final messageResponse = MessageResponse(
        status: responseStatus,
        title: responseTitle,
        message: responseMessage,
      );

      if (status == 1) {
        emit(
          ReservationBook(
            message: messageResponse,
            bookingId: dataState.data!.data['id'],
            redirectUrl: dataState.data!.data['redirect_url'],
          ),
        );
      } else {
        emit(
          ReservationBook(
            message: messageResponse,
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(ReservationError(dataState.error!));
    }
  }

  void onGetReservations(
    GetReservations event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const ReservationLoading());

    final dataState = await _getReservationsUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final reservations = (dataState.data!.data as List).map((booking) => ReservationModel.fromJson(booking)).toList();

        emit(
          ReservationDone(reservations),
        );
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(ReservationError(dataState.error!));
    }
  }

  void onGetReservationDetail(
    GetReservationDetail event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const ReservationLoading());

    final dataState = await _getReservationDetailUseCase(
      params: event.bookingId,
    );

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final reservationDetail = ReservationDetailModel.fromJson(
          dataState.data!.data,
        );

        emit(
          ReservationDetail(reservationDetail),
        );
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(ReservationError(dataState.error!));
    }
  }
}
