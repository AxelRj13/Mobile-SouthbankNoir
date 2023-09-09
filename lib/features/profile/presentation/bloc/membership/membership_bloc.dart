import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/membership.dart';
import '../../../domain/usecases/get_membership.dart';
import 'membership_event.dart';
import 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final GetMembershipUseCase _getMembershipUseCase;

  MembershipBloc(this._getMembershipUseCase)
      : super(const MembershipLoading()) {
    on<GetMembership>(onGetMembership);
  }

  void onGetMembership(
    GetMembership event,
    Emitter<MembershipState> emit,
  ) async {
    final dataState = await _getMembershipUseCase();

    if (dataState is DataSuccess) {
      final membership = MembershipModel.fromJson(dataState.data!.data);

      emit(MembershipDone(membership));
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(MembershipError(dataState.error!));
    }
  }
}
