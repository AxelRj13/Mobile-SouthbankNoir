import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/loading.dart';
import '../bloc/confirmation/confirmation_bloc.dart';
import '../bloc/confirmation/confirmation_event.dart';
import '../bloc/confirmation/confirmation_state.dart';
import '../bloc/payment/payment_bloc.dart';
import '../bloc/payment/payment_state.dart';

class PaymentConfirmWidget extends StatefulWidget {
  final String bookingId;

  const PaymentConfirmWidget({
    super.key,
    required this.bookingId,
  });

  @override
  State<PaymentConfirmWidget> createState() => _PaymentConfirmWidgetState();
}

class _PaymentConfirmWidgetState extends State<PaymentConfirmWidget> {
  Widget buildDetailInformation({
    required TextTheme textTheme,
    required String label,
    required String information,
    Widget? trailing,
  }) {
    return Row(
      mainAxisAlignment: trailing != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: textTheme.bodyMedium!.copyWith(fontSize: 18.0),
            ),
            const SizedBox(height: 5.0),
            Text(
              information,
              style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (trailing != null) trailing
      ],
    );
  }

  Widget buildHowToPayInformation(MapEntry<int, String> item) {
    final numbering = '${item.key + 1}.';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(numbering),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              item.value.replaceAll(numbering, '').trim(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHowToPayExpansionTile({
    required String label,
    required List<String> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          iconColor: Colors.white,
          childrenPadding: const EdgeInsets.all(15.0),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          children: items.asMap().entries.map((item) => buildHowToPayInformation(item)).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state is PaymentDone) {
          final textTheme = Theme.of(context).textTheme;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailInformation(
                    textTheme: textTheme,
                    label: 'Order ID',
                    information: state.payment!.orderId!,
                  ),
                  const Divider(
                    thickness: 2.0,
                    height: 30.0,
                  ),
                  buildDetailInformation(
                    textTheme: textTheme,
                    label: 'Virtual Account Number',
                    information: state.payment!.vaNumber!,
                    trailing: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(accentColor),
                      ),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: state.payment!.vaNumber!,
                          ),
                        ).then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Virtual account copied'),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Copy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2.0,
                    height: 30.0,
                  ),
                  buildDetailInformation(
                    textTheme: textTheme,
                    label: 'Total Payment',
                    information: state.payment!.subtotal!,
                  ),
                  const Divider(
                    thickness: 2.0,
                    height: 30.0,
                  ),
                  Text(
                    'How to Pay',
                    style: textTheme.bodyMedium!.copyWith(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  buildHowToPayExpansionTile(
                    label: 'ATM',
                    items: state.payment!.atmInstructions!,
                  ),
                  buildHowToPayExpansionTile(
                    label: 'Mobile Banking',
                    items: state.payment!.mobileInstructions!,
                  ),
                  buildHowToPayExpansionTile(
                    label: 'Internet Banking',
                    items: state.payment!.internetInstructions!,
                  ),
                  BlocBuilder<ConfirmationPaymentBloc, ConfirmationPaymentState>(
                    builder: (context, state) {
                      return SBButton(
                        onPressed: (state is ConfirmationPaymentLoading)
                            ? null
                            : () {
                                BlocProvider.of<ConfirmationPaymentBloc>(context).add(
                                  ConfirmPayment(
                                    bookingId: widget.bookingId,
                                  ),
                                );
                              },
                        child: (state is ConfirmationPaymentLoading)
                            ? const Center(
                                child: SBLoading(color: Colors.white),
                              )
                            : const Text('I have Paid'),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        if (state is PaymentError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }

        return const Center(
          child: SBLoading(),
        );
      },
    );
  }
}
