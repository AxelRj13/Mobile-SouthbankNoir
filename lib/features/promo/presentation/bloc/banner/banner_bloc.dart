import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/banner.dart';
import '../../../domain/usecases/get_banner.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannerUseCase _getBannerUseCase;

  BannerBloc(this._getBannerUseCase) : super(const BannerLoading()) {
    on<GetBanner>(onGetBanner);
  }

  void onGetBanner(
    GetBanner event,
    Emitter<BannerState> emit,
  ) async {
    emit(const BannerLoading());

    final dataState = await _getBannerUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final banners = (dataState.data!.data as List)
            .map(
              (item) => BannerModel.fromJson(item),
            )
            .toList();

        emit(
          BannerDone(banner: banners),
        );
      } else {
        emit(const BannerNotFound());
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(BannerError(dataState.error!));
    }
  }
}
