import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/dialog.dart';
import '../../../injection_container.dart';
import 'bloc/promo/reservation_promo_bloc.dart';
import 'bloc/promo/reservation_promo_state.dart';
import 'bloc/reservation/reservation_bloc.dart';
import 'bloc/reservation/reservation_event.dart';
import 'widgets/confirmation_widget.dart';

class ConfirmationScreen extends StatefulWidget {
  final String bookingId;

  const ConfirmationScreen({
    super.key,
    required this.bookingId,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ReservationBloc>(
            create: (context) => getIt.get<ReservationBloc>()
              ..add(
                GetReservationDetail(
                  bookingId: widget.bookingId,
                ),
              ),
          ),
          BlocProvider<ReservationPromoBloc>(
            create: (context) => getIt.get<ReservationPromoBloc>(),
          ),
        ],
        child: BlocListener<ReservationPromoBloc, ReservationPromoState>(
          listener: (context, state) async {
            if (state is ReservationPromo) {
              await basicDialog(
                context,
                state.message!.title,
                state.message!.message,
              );
            }
          },
          child: ConfirmationWidget(bookingId: widget.bookingId),
        ),
      ),
    );
  }
}
