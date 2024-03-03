import 'package:flutter/material.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/not_found.dart';
import '../bloc/coupon/coupon_state.dart';
import 'coupon_tile.dart';

class TabCoupons extends StatefulWidget {
  final CouponState state;

  const TabCoupons({
    super.key,
    required this.state,
  });

  @override
  State<TabCoupons> createState() => _TabCouponsState();
}

class _TabCouponsState extends State<TabCoupons> {
  @override
  Widget build(BuildContext context) {
    if (widget.state is CouponNotFound) {
      return const NotFoundWidget();
    }

    if (widget.state is CouponError) {
      return const Icon(Icons.refresh);
    }

    if (widget.state is CouponsDone) {
      return Column(
        children: widget.state.coupons!
            .map(
              (coupon) => CouponTileWidget(
                tabIndex: buyCoupon,
                coupon: coupon,
              ),
            )
            .toList(),
      );
    }

    return const SBLoading();
  }
}
