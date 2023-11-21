import 'package:flutter/material.dart';

import '../data/models/payment.dart';
import 'widgets/payment_widget.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentModel payment;

  const PaymentScreen({
    super.key,
    required this.payment,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          automaticallyImplyLeading: false,
        ),
        body: PaymentWidget(payment: widget.payment),
      ),
    );
  }
}
