import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/resources/message_response.dart';

abstract class ComplaintState extends Equatable {
  final MessageResponse? message;
  final DioException? error;

  const ComplaintState({this.message, this.error});

  @override
  List<Object> get props => [message!, error!];
}

class PrepareComplaint extends ComplaintState {
  const PrepareComplaint();
}

class ComplaintLoading extends ComplaintState {
  const ComplaintLoading();
}

class ComplaintSent extends ComplaintState {
  const ComplaintSent(MessageResponse? message) : super(message: message);
}

class ComplaintError extends ComplaintState {
  const ComplaintError(DioException error) : super(error: error);
}
