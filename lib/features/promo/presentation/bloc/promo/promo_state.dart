import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/promo.dart';
import '../../../data/models/promo_list.dart';

abstract class PromoState extends Equatable {
  final PromoModel? promo;
  final List<PromoListModel>? promoList;
  final DioException? error;

  const PromoState({this.promo, this.promoList, this.error});

  @override
  List<Object> get props => [promo!, promoList!, error!];
}

class PromoLoading extends PromoState {
  const PromoLoading();
}

class PromoListDone extends PromoState {
  const PromoListDone(List<PromoListModel> promoList)
      : super(promoList: promoList);
}

class PromoDone extends PromoState {
  const PromoDone(PromoModel promo) : super(promo: promo);
}

class PromoError extends PromoState {
  const PromoError(DioException error) : super(error: error);
}
