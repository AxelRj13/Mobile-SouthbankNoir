import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:southbank/core/components/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/loading.dart';
import '../bloc/confirmation/confirmation_bloc.dart';
import '../bloc/confirmation/confirmation_event.dart';
import '../bloc/confirmation/confirmation_state.dart';
import '../bloc/payment/payment_bloc.dart';
import '../bloc/payment/payment_event.dart';
import '../bloc/payment/payment_state.dart';

class PaymentConfirmWidget extends StatefulWidget {
  final String bookingId;
  final String redirectUrl;

  const PaymentConfirmWidget({
    super.key,
    required this.bookingId,
    required this.redirectUrl,
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

  List<Widget> buildVAInformation({
    required TextTheme textTheme,
    required String orderId,
    required String vaNumber,
    required String subtotal,
    required List<String> atmInstructions,
    required List<String> mobileInstructions,
    required List<String> internetInstructions,
  }) {
    return [
      buildDetailInformation(
        textTheme: textTheme,
        label: 'Order ID',
        information: orderId,
      ),
      const Divider(
        thickness: 2.0,
        height: 30.0,
      ),
      buildDetailInformation(
        textTheme: textTheme,
        label: 'Virtual Account Number',
        information: vaNumber,
        trailing: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(accentColor),
          ),
          onPressed: () {
            Clipboard.setData(
              ClipboardData(
                text: vaNumber,
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
        information: subtotal,
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
        items: atmInstructions,
      ),
      buildHowToPayExpansionTile(
        label: 'Mobile Banking',
        items: mobileInstructions,
      ),
      buildHowToPayExpansionTile(
        label: 'Internet Banking',
        items: internetInstructions,
      ),
    ];
  }

  List<Widget> buildRedirectURLInformation({
    required TextTheme textTheme,
  }) {
    return [
      Text(
        'How to Pay',
        style: textTheme.bodyMedium!.copyWith(fontSize: 18.0),
      ),
      const SizedBox(height: 20.0),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  style: textTheme.bodyMedium!.copyWith(fontSize: 16.0),
                  text:
                      'Payment using E-Wallet or Credit Card will be redirected to another page first. If you are not directed to the payment page you can tap through '),
              TextSpan(
                  style: textTheme.bodyMedium!.copyWith(
                    decoration: TextDecoration.underline,
                    color: accentColor,
                  ),
                  text: 'this link',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final uri = Uri.parse(widget.redirectUrl);
                      if (await canLaunchUrl(uri)) {
                        launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        if (mounted) await basicDialog(context, 'Information', 'Could not open the URL');
                      }
                    }),
              TextSpan(
                  style: textTheme.bodyMedium!.copyWith(fontSize: 16.0),
                  text:
                      '. Make sure you have made a payment before the transaction expires. After the system checks the payment has been made then you will be redirected automatically, if not you can confirm the payment via the \'I Have Paid\' button.'),
            ]),
          ),
        ),
      ),
      const SizedBox(height: 20.0),
    ];
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
                  if (state.payment!.vaNumber != null)
                    ...buildVAInformation(
                      textTheme: textTheme,
                      orderId: state.payment!.orderId!,
                      vaNumber: state.payment!.vaNumber!,
                      subtotal: state.payment!.subtotal!,
                      atmInstructions: state.payment!.atmInstructions!,
                      mobileInstructions: state.payment!.mobileInstructions!,
                      internetInstructions: state.payment!.internetInstructions!,
                    ),
                  if (state.payment!.vaNumber == null) ...buildRedirectURLInformation(textTheme: textTheme),
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
          return Center(
            child: InkWell(
              onTap: () {
                BlocProvider.of<PaymentBloc>(context).add(
                  GetPayment(
                    bookingId: widget.bookingId,
                  ),
                );
              },
              child: const Icon(Icons.refresh),
            ),
          );
        }

        return const Center(
          child: SBLoading(),
        );
      },
    );
  }
}
