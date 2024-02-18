import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/dialog.dart';
import '../../../../core/components/loading.dart';
import '../../domain/entities/coupon.dart';
import '../bloc/coupon/coupon_bloc.dart';
import '../bloc/coupon/coupon_state.dart';
import '../bloc/coupon_purchased/coupon_purchased_bloc.dart';
import '../bloc/coupon_purchased/coupon_purchased_event.dart';
import '../bloc/coupon_purchased/coupon_purchased_state.dart';

class DetailCouponInformation extends StatefulWidget {
  final CouponEntity coupon;

  const DetailCouponInformation({super.key, required this.coupon});

  @override
  State<DetailCouponInformation> createState() => _DetailCouponInformationState();
}

class _DetailCouponInformationState extends State<DetailCouponInformation> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CouponPurchasedBloc, CouponPurchasedState>(
      listener: (context, state) async {
        if (state is CouponPurchased) {
          await basicDialog(
            context,
            state.message!.title,
            state.message!.message,
          );
        }

        if (state is CouponPurchasedError) {
          if (context.mounted) await exceptionDialog(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      widget.coupon.name!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10.0),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.coupon.price!,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: accentColor),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 2.0,
                            width: 30.0,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Validity Period',
                                  style: TextStyle(color: accentColor),
                                ),
                                Text('${widget.coupon.startDate} - ${widget.coupon.endDate}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Text(widget.coupon.description ?? ''),
            const SizedBox(height: 30.0),
            BlocBuilder<CouponBloc, CouponState>(
              builder: (context, state) {
                return SBButton(
                  onPressed: (state is CouponPurchasedLoading)
                      ? null
                      : () async {
                          final isConfirm = await confirmDialog(
                            context,
                            'Confirmation',
                            'Do you want to buy this coupon?',
                          );

                          if (isConfirm ?? false) {
                            if (mounted) {
                              BlocProvider.of<CouponPurchasedBloc>(context).add(
                                BuyCoupon(couponId: widget.coupon.id ?? ''),
                              );
                            }
                          }
                        },
                  child: (state is CouponPurchasedLoading)
                      ? const Center(
                          child: SBLoading(color: Colors.white),
                        )
                      : const Text('Buy Coupon'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
