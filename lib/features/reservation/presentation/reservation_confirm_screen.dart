import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/routes/router.dart';
import '../../../core/components/dialog.dart';
import '../../../injection_container.dart';
import '../data/models/reservation_confirm.dart';
import 'bloc/payment_method/payment_method_bloc.dart';
import 'bloc/payment_method/payment_method_event.dart';
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
          BlocProvider<PaymentMethodBloc>(
            create: (context) => getIt.get<PaymentMethodBloc>()..add(const GetPaymentMethods()),
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
                    if (state.redirectUrl != null) {
                      final uri = Uri.parse(state.redirectUrl!);
                      if (await canLaunchUrl(uri)) {
                        launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    }
                    router.goNamed(
                      'payment',
                      pathParameters: {
                        'bookingId': state.bookingId!,
                      },
                      queryParameters: {
                        'redirectUrl': state.redirectUrl,
                      },
                    );
                  } else {
                    if (context.mounted) Navigator.of(context).pop(true);
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
