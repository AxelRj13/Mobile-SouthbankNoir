import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/image_header.dart';
import '../../../../core/components/loading.dart';
import '../bloc/coupon/coupon_bloc.dart';
import '../bloc/coupon/coupon_event.dart';
import '../bloc/coupon/coupon_state.dart';
import 'detail_coupon_information.dart';
import 'detail_my_coupon_information.dart';

class CouponDetail extends StatefulWidget {
  final bool isMyCoupon;
  final String id;

  const CouponDetail({
    super.key,
    required this.isMyCoupon,
    required this.id,
  });

  @override
  State<CouponDetail> createState() => _CouponDetailState();
}

class _CouponDetailState extends State<CouponDetail> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final couponId = widget.id;
      final blocEvent = widget.isMyCoupon
          ? GetMyCoupon(id: couponId)
          : GetCoupon(id: couponId);
      context.read<CouponBloc>().add(blocEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponBloc, CouponState>(
      builder: (context, state) {
        if (state is CouponLoading) {
          return const Center(child: SBLoading());
        }

        if (state is CouponError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is CouponDone) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBImageHeader(image: state.coupon!.image),
                widget.isMyCoupon
                    ? DetailMyCouponInformation(coupon: state.coupon!)
                    : DetailCouponInformation(coupon: state.coupon!)
              ],
            ),
          );
        }

        return const Center(child: Text('No data'));
      },
    );
  }
}
