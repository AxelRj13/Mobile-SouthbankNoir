import 'package:flutter/material.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/animated_check.dart';
import '../../../../core/components/button.dart';
import '../../data/models/payment.dart';

class PaymentWidget extends StatefulWidget {
  final PaymentModel payment;

  const PaymentWidget({
    super.key,
    required this.payment,
  });

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  Widget buildTitle({
    required TextTheme textTheme,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        label,
        style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildInformation({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final payment = widget.payment;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: AnimatedCheck(),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Payment Successful',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
            const Divider(
              thickness: 2.0,
              height: 30.0,
            ),
            buildTitle(textTheme: theme.textTheme, label: 'Receipt Reference No.'),
            Text(payment.receiptRefNumber!),
            const Divider(
              thickness: 2.0,
              height: 30.0,
            ),
            Card(
              margin: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: accentColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: buildTitle(
                        textTheme: theme.textTheme,
                        label: 'Your Booking',
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        '#${payment.bookingNo!}',
                        style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildInformation(label: 'Date', value: payment.reservationDate!),
                    buildInformation(label: 'Table', value: payment.tableName!),
                    buildInformation(label: 'Capacity', value: payment.tableCapacity!),
                    buildInformation(label: 'Minimum Spend', value: payment.minimumSpend!),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: accentColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.info,
                              ),
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 5.0),
                            ),
                            TextSpan(
                              text: 'Important Notice',
                              style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Please show your valid ID and confirmed orders from this page / ',
                          ),
                          TextSpan(
                            text: 'My Bookings',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' page to our receptionist.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: SBButton(
                    onPressed: () {
                      router.goNamed('main');
                    },
                    color: Colors.grey,
                    child: const Text('Back to Home'),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: SBButton(
                    onPressed: () {
                      router.goNamed('myBooking');
                    },
                    child: const Text('My Bookings'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
