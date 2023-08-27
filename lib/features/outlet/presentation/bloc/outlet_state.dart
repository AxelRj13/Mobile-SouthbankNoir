import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/operational_hours.dart';
import '../../data/models/outlet.dart';

abstract class OutletState extends Equatable {
  final OutletModel? outlet;
  final List<OperationalHoursModel>? operationalHours;
  final OperationalHoursModel? todayOperationalHour;
  final DioException? error;

  const OutletState(
      {this.outlet,
      this.operationalHours,
      this.todayOperationalHour,
      this.error});

  @override
  List<Object> get props =>
      [outlet!, operationalHours!, todayOperationalHour!, error!];
}

class OutletLoading extends OutletState {
  const OutletLoading();
}

class OutletDone extends OutletState {
  const OutletDone(
    OutletModel outlet,
    List<OperationalHoursModel> operationalHours,
    OperationalHoursModel todayOperationalHour,
  ) : super(
          outlet: outlet,
          operationalHours: operationalHours,
          todayOperationalHour: todayOperationalHour,
        );
}

class OutletError extends OutletState {
  const OutletError(DioException error) : super(error: error);
}
