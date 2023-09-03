import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/banner.dart';

abstract class BannerState extends Equatable {
  final List<BannerEntity>? banners;
  final DioException? error;

  const BannerState({this.banners, this.error});

  @override
  List<Object> get props => [banners!, error!];
}

class BannerLoading extends BannerState {
  const BannerLoading();
}

class BannerDone extends BannerState {
  const BannerDone(List<BannerEntity> banner) : super(banners: banner);
}

class BannerError extends BannerState {
  const BannerError(DioException error) : super(error: error);
}
