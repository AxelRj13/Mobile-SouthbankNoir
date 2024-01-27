import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/banner.dart';

abstract class BannerState extends Equatable {
  final List<BannerModel>? banners;
  final DioException? error;

  const BannerState({
    this.banners,
    this.error,
  });

  @override
  List<Object> get props => [
        banners!,
        error!,
      ];
}

class BannerLoading extends BannerState {
  const BannerLoading();
}

class BannerDone extends BannerState {
  const BannerDone({
    required List<BannerModel> banner,
  }) : super(
          banners: banner,
        );
}

class BannerNotFound extends BannerState {
  const BannerNotFound();
}

class BannerError extends BannerState {
  const BannerError(
    DioException error,
  ) : super(
          error: error,
        );
}
