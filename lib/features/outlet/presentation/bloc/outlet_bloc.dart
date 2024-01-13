import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/operational_hours.dart';
import '../../data/models/outlet.dart';
import '../../domain/usecases/get_outlet_details.dart';
import 'outlet_event.dart';
import 'outlet_state.dart';

class OutletBloc extends Bloc<OutletEvent, OutletState> {
  final GetOutletDetailsUseCase _getOutletDetailsUseCase;

  OutletBloc(this._getOutletDetailsUseCase) : super(const OutletLoading()) {
    on<GetOutlet>(onGetOutlet);
  }

  void onGetOutlet(
    GetOutlet event,
    Emitter<OutletState> emit,
  ) async {
    final dataState = await _getOutletDetailsUseCase();

    if (dataState is DataSuccess) {
      final outletList = (dataState.data!.data['store'] as List).map((item) => OutletModel.fromJson(item)).toList();

      final outlet = outletList.first;

      final operationalHours = (dataState.data!.data['operational_hours'] as List).map((item) => OperationalHoursModel.fromJson(item)).toList();

      final todayOperationalHour = operationalHours.where((e) => e.isToday!).toList().first;

      emit(
        OutletDone(outlet, operationalHours, todayOperationalHour),
      );
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(OutletError(dataState.error!));
    }
  }
}
