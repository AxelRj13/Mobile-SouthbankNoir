import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/complaint_type.dart';

abstract class ComplaintTypeState extends Equatable {
  final List<ComplaintTypeModel>? types;
  final DioException? error;

  const ComplaintTypeState({
    this.types,
    this.error,
  });

  @override
  List<Object> get props => [
        types!,
        error!,
      ];
}

class ComplaintTypeLoading extends ComplaintTypeState {
  const ComplaintTypeLoading();
}

class ComplaintTypeDone extends ComplaintTypeState {
  const ComplaintTypeDone({
    required List<ComplaintTypeModel> types,
  }) : super(
          types: types,
        );
}

class ComplaintTypeNotFound extends ComplaintTypeState {
  const ComplaintTypeNotFound();
}

class ComplaintTypeError extends ComplaintTypeState {
  const ComplaintTypeError(
    DioException error,
  ) : super(
          error: error,
        );
}
