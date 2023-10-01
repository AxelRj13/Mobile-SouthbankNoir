import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/utils/formatter.dart';
import '../bloc/coupon/coupon_bloc.dart';
import '../bloc/coupon/coupon_state.dart';

class CouponPointCard extends StatelessWidget {
  const CouponPointCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CouponBloc, CouponState>(
      builder: (_, state) {
        int points = 0;

        if (state is CouponsDone) {
          points = state.points!;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: SizedBox(
            height: size.height * 0.06,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              color: accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      right: 15.0,
                      bottom: 10.0,
                      left: 10.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD98200),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                    child: const Icon(Icons.wallet),
                  ),
                  const SizedBox(width: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      Intl.plural(
                        points,
                        zero: '${UtilsFormatter.decimalFormat(points)} Point',
                        one: '${UtilsFormatter.decimalFormat(points)} Point',
                        other: '${UtilsFormatter.decimalFormat(points)} Points',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
