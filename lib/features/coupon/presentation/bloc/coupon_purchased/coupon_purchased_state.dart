import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/resources/message_response.dart';

abstract class CouponPurchasedState extends Equatable {
  final MessageResponse? message;
  final DioException? error;

  const CouponPurchasedState({
    this.message,
    this.error,
  });

  @override
  List<Object> get props => [
        message!,
        error!,
      ];
}

class CouponPurchasedInitial extends CouponPurchasedState {
  const CouponPurchasedInitial();
}

class CouponPurchasedLoading extends CouponPurchasedState {
  const CouponPurchasedLoading();
}

class CouponPurchased extends CouponPurchasedState {
  const CouponPurchased(MessageResponse? message) : super(message: message);
}

class CouponPurchasedError extends CouponPurchasedState {
  const CouponPurchasedError(DioException error) : super(error: error);
}
