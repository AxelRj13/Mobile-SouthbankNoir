import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/promo.dart';
import '../../../data/models/promo_list.dart';
import '../../../domain/usecases/get_promo.dart';
import '../../../domain/usecases/get_promo_list.dart';
import 'promo_event.dart';
import 'promo_state.dart';

class PromoBloc extends Bloc<PromoEvent, PromoState> {
  final GetPromoListUseCase _getPromoListUseCase;
  final GetPromoUseCase _getPromoUseCase;

  PromoBloc(
    this._getPromoListUseCase,
    this._getPromoUseCase,
  ) : super(const PromoLoading()) {
    on<GetPromoList>(onGetPromoList);
    on<GetPromo>(onPromoNews);
  }

  void onGetPromoList(
    GetPromoList event,
    Emitter<PromoState> emit,
  ) async {
    final dataState = await _getPromoListUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final news = (dataState.data!.data as List)
            .map((item) => PromoListModel.fromJson(item))
            .toList();

        emit(PromoListDone(news));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(PromoError(dataState.error!));
    }
  }

  void onPromoNews(
    GetPromo event,
    Emitter<PromoState> emit,
  ) async {
    final dataState = await _getPromoUseCase(params: event.id);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final news = PromoModel.fromJson(dataState.data!.data);

        emit(PromoDone(news));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(PromoError(dataState.error!));
    }
  }
}
