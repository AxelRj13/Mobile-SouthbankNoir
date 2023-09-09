import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/membership.dart';

abstract class MembershipState extends Equatable {
  final MembershipModel? membership;
  final DioException? error;

  const MembershipState({
    this.membership,
    this.error,
  });

  @override
  List<Object> get props => [membership!, error!];
}

class MembershipLoading extends MembershipState {
  const MembershipLoading();
}

class MembershipDone extends MembershipState {
  const MembershipDone(MembershipModel membership)
      : super(membership: membership);
}

class MembershipError extends MembershipState {
  const MembershipError(DioException error) : super(error: error);
}
