import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/complaint_type.dart';
import '../../../domain/usecases/get_complaint_types.dart';
import 'complaint_type_event.dart';
import 'complaint_type_state.dart';

class ComplaintTypeBloc extends Bloc<ComplaintTypeEvent, ComplaintTypeState> {
  final GetComplaintTypesUseCase _getComplaintTypesUseCase;

  ComplaintTypeBloc(this._getComplaintTypesUseCase) : super(const ComplaintTypeLoading()) {
    on<GetComplaintTypes>(onGetComplaintTypes);
  }

  void onGetComplaintTypes(
    GetComplaintTypes event,
    Emitter<ComplaintTypeState> emit,
  ) async {
    final dataState = await _getComplaintTypesUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final types = (dataState.data!.data as List).map((item) => ComplaintTypeModel.fromJson(item)).toList();

        emit(ComplaintTypeDone(types));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(ComplaintTypeError(dataState.error!));
    }
  }
}
