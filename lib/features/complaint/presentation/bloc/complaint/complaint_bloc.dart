import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/message_response.dart';
import '../../../domain/entities/complaint_request.dart';
import '../../../domain/usecases/send_complaint.dart';
import 'complaint_event.dart';
import 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final SendComplaintUseCase _sendComplaintUseCase;

  ComplaintBloc(this._sendComplaintUseCase) : super(const PrepareComplaint()) {
    on<SendComplaint>(onSendComplaint);
  }

  void onSendComplaint(
    SendComplaint event,
    Emitter<ComplaintState> emit,
  ) async {
    emit(const ComplaintLoading());

    final complaintRequest = ComplaintRequest(
      type: event.type,
      date: event.date,
      store: event.store,
      description: event.description,
    );

    final dataState = await _sendComplaintUseCase(params: complaintRequest);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      bool responseStatus = status == 1;
      String responseTitle = 'Oppss...';
      String responseMessage = 'Failed to send complaint';

      if (status == 1) {
        responseTitle = 'Thank you!';
        responseMessage = dataState.data!.message!;
      }

      final messageResponse = MessageResponse(
        status: responseStatus,
        title: responseTitle,
        message: responseMessage,
      );

      emit(ComplaintSent(messageResponse));
    }

    if (dataState is DataFailed) {
      emit(ComplaintError(dataState.error!));
    }
  }
}
