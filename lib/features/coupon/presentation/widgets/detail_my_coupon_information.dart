import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/coupon.dart';

class DetailMyCouponInformation extends StatelessWidget {
  final CouponEntity coupon;

  const DetailMyCouponInformation({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            coupon.name!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.calendar_month,
                    size: MediaQuery.of(context).size.width * 0.04,
                    color: accentColor,
                  ),
                ),
                const WidgetSpan(
                  child: SizedBox(width: 5.0),
                ),
                TextSpan(
                  text: '${coupon.startDate} - ${coupon.endDate}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: accentColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          InkWell(
            onTap: () async {
              Clipboard.setData(ClipboardData(text: coupon.code ?? '')).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Coupon code copied'),
                  ),
                ),
              );
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: coupon.code,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: accentColor),
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 5.0),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.copy,
                      size: MediaQuery.of(context).size.width * 0.04,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Text(coupon.description ?? ''),
        ],
      ),
    );
  }
}
