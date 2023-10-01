import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/coupon.dart';
import '../../../data/models/coupon_list.dart';
import '../../../domain/usecases/get_coupon.dart';
import '../../../domain/usecases/get_coupons.dart';
import '../../../domain/usecases/get_my_coupon.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final GetCouponsUseCase _getCouponsUseCase;
  final GetCouponUseCase _getCouponUseCase;
  final GetMyCouponUseCase _getMyCouponUseCase;

  CouponBloc(
    this._getCouponsUseCase,
    this._getCouponUseCase,
    this._getMyCouponUseCase,
  ) : super(const CouponInitial()) {
    on<GetCoupons>(onGetCoupons);
    on<GetCoupon>(onGetCoupon);
    on<GetMyCoupon>(onGetMyCoupon);
  }

  void onGetCoupons(
    GetCoupons event,
    Emitter<CouponState> emit,
  ) async {
    emit(const CouponLoading());

    final dataState = await _getCouponsUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final response = dataState.data!.data as Map<String, dynamic>;

        final points = response.containsKey('points') ? response['points'] : 0;

        final coupons = response.containsKey('coupons')
            ? (response['coupons'] as List)
                .map((item) => CouponListModel.fromJson(item))
                .toList()
            : null;

        final myCoupons = response.containsKey('my_coupons')
            ? (response['my_coupons'] as List)
                .map((item) => CouponListModel.fromJson(item))
                .toList()
            : null;

        emit(CouponsDone(points, coupons, myCoupons));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(CouponError(dataState.error!));
    }
  }

  void onGetCoupon(
    GetCoupon event,
    Emitter<CouponState> emit,
  ) async {
    emit(const CouponLoading());

    final dataState = await _getCouponUseCase(params: event.id);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final coupon = CouponModel.fromJson(dataState.data!.data);

        emit(CouponDone(coupon));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(CouponError(dataState.error!));
    }
  }

  void onGetMyCoupon(
    GetMyCoupon event,
    Emitter<CouponState> emit,
  ) async {
    emit(const CouponLoading());

    final dataState = await _getMyCouponUseCase(params: event.id);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final coupon = CouponModel.fromJson(dataState.data!.data);

        emit(CouponDone(coupon));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(CouponError(dataState.error!));
    }
  }
}
