import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/router.dart';
import '../../../core/components/dialog.dart';
import '../../../injection_container.dart';
import 'bloc/confirmation/confirmation_bloc.dart';
import 'bloc/confirmation/confirmation_state.dart';
import 'bloc/payment/payment_bloc.dart';
import 'bloc/payment/payment_event.dart';
import 'bloc/payment/payment_state.dart';
import 'widgets/payment_confirm_widget.dart';

class PaymentConfirmScreen extends StatefulWidget {
  final String bookingId;

  const PaymentConfirmScreen({
    super.key,
    required this.bookingId,
  });

  @override
  State<PaymentConfirmScreen> createState() => _PaymentConfirmScreenState();
}

class _PaymentConfirmScreenState extends State<PaymentConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PaymentBloc>(
            create: (context) => getIt.get<PaymentBloc>()
              ..add(
                GetPayment(
                  bookingId: widget.bookingId,
                ),
              ),
          ),
          BlocProvider<ConfirmationPaymentBloc>(
            create: (context) => getIt.get<ConfirmationPaymentBloc>(),
          ),
        ],
        child: BlocListener<ConfirmationPaymentBloc, ConfirmationPaymentState>(
          listener: (context, state) async {
            if (state is ConfirmationPaymentDone) {
              if (state.message!.status) {
                router.pushReplacementNamed(
                  'paymentConfirm',
                  pathParameters: {'bookingId': widget.bookingId},
                  extra: state.payment!,
                );
              } else {
                await basicDialog(
                  context,
                  state.message!.title,
                  state.message!.message,
                );
              }
            }

            if (state is PaymentError) {
              if (context.mounted) await exceptionDialog(context);
            }
          },
          child: PaymentConfirmWidget(
            bookingId: widget.bookingId,
          ),
        ),
      ),
    );
  }
}
