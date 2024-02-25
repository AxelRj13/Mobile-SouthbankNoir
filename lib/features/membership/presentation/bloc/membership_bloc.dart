import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/membership.dart';
import '../../domain/usecases/get_membership.dart';
import 'membership_event.dart';
import 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final GetMembershipUseCase _getMembershipUseCase;

  MembershipBloc(this._getMembershipUseCase) : super(const MembershipLoading()) {
    on<GetMembership>(onGetMembership);
  }

  void onGetMembership(
    GetMembership event,
    Emitter<MembershipState> emit,
  ) async {
    emit(const MembershipLoading());

    final dataState = await _getMembershipUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      MembershipModel membership = const MembershipModel(
        points: 0,
        totalSpent: 0,
        name: 'Unknown',
        totalSpentMax: 20000000,
        diffNextTier: 'Unknown Tier',
        totalTiers: 4,
      );

      if (status == 1) {
        membership = MembershipModel.fromJson(dataState.data!.data);
      }

      emit(
        MembershipDone(membership: membership),
      );
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(MembershipError(dataState.error!));
    }
  }
}
