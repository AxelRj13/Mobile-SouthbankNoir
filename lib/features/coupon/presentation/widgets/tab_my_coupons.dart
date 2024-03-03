import 'package:flutter/material.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/not_found.dart';
import '../bloc/coupon/coupon_state.dart';
import 'coupon_tile.dart';

class TabMyCoupons extends StatefulWidget {
  final CouponState state;

  const TabMyCoupons({
    super.key,
    required this.state,
  });

  @override
  State<TabMyCoupons> createState() => _TabMyCouponsState();
}

class _TabMyCouponsState extends State<TabMyCoupons> {
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
        children: widget.state.myCoupons!
            .map(
              (coupon) => CouponTileWidget(
                tabIndex: myCoupon,
                coupon: coupon,
              ),
            )
            .toList(),
      );
    }

    return const SBLoading();
  }
}
