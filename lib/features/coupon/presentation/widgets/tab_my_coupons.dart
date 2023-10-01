import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/constants/constants.dart';
import '../bloc/coupon/coupon_bloc.dart';
import '../bloc/coupon/coupon_state.dart';
import 'coupon_tile.dart';

class TabMyCoupons extends StatefulWidget {
  const TabMyCoupons({super.key});

  @override
  State<TabMyCoupons> createState() => _TabMyCouponsState();
}

class _TabMyCouponsState extends State<TabMyCoupons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<CouponBloc, CouponState>(
        builder: (_, state) {
          if (state is CouponLoading) {
            return const SBLoading();
          }

          if (state is CouponError) {
            return const Icon(Icons.refresh);
          }

          if (state is CouponsDone) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return CouponTileWidget(
                  tabIndex: myCoupon,
                  coupon: state.myCoupons![index],
                );
              },
              itemCount: state.myCoupons!.length,
            );
          }

          return const Text('No data');
        },
      ),
    );
  }
}
