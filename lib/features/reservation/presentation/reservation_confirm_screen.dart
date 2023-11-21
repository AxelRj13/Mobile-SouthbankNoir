import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/router.dart';
import '../../../core/components/dialog.dart';
import '../../../injection_container.dart';
import '../data/models/reservation_confirm.dart';
import 'bloc/promo/reservation_promo_bloc.dart';
import 'bloc/promo/reservation_promo_state.dart';
import 'bloc/reservation/reservation_bloc.dart';
import 'bloc/reservation/reservation_state.dart';
import 'widgets/reservation_confirm_widget.dart';

class ReservationConfirmScreen extends StatefulWidget {
  final ReservationConfirmModel reservationConfirm;

  const ReservationConfirmScreen({
    super.key,
    required this.reservationConfirm,
  });

  @override
  State<ReservationConfirmScreen> createState() => _ReservationConfirmScreenState();
}

class _ReservationConfirmScreenState extends State<ReservationConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ReservationPromoBloc>(
            create: (context) => getIt.get<ReservationPromoBloc>(),
          ),
          BlocProvider<ReservationBloc>(
            create: (context) => getIt.get<ReservationBloc>(),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ReservationPromoBloc, ReservationPromoState>(
              listener: (context, state) async {
                if (state is ReservationPromo) {
                  await basicDialog(
                    context,
                    state.message!.title,
                    state.message!.message,
                  );
                }

                if (state is ReservationPromoError) {
                  if (context.mounted) await exceptionDialog(context);
                }
              },
            ),
            BlocListener<ReservationBloc, ReservationState>(
              listener: (context, state) async {
                if (state is ReservationBook) {
                  await basicDialog(
                    context,
                    state.message!.title,
                    state.message!.message,
                  );

                  if (state.message!.status) {
                    router.goNamed(
                      'payment',
                      pathParameters: {
                        'bookingId': state.bookingId!,
                      },
                    );
                  }
                }

                if (state is ReservationError) {
                  if (context.mounted) await exceptionDialog(context);
                }
              },
            ),
          ],
          child: ReservationConfirmWidget(reservationConfirm: widget.reservationConfirm),
        ),
      ),
    );
  }
}
