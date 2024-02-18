import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../injection_container.dart';
import 'bloc/coupon/coupon_bloc.dart';
import 'bloc/coupon_purchased/coupon_purchased_bloc.dart';
import 'widgets/coupon_detail.dart';

class CouponDetailScreen extends StatefulWidget {
  final String type;
  final String id;

  const CouponDetailScreen({
    super.key,
    required this.type,
    required this.id,
  });

  @override
  State<CouponDetailScreen> createState() => _CouponDetailScreenState();
}

class _CouponDetailScreenState extends State<CouponDetailScreen> {
  bool isMyCoupon = false;

  String appbarTitle() {
    return isMyCoupon ? 'My Coupon' : 'Coupon Detail';
  }

  @override
  void initState() {
    super.initState();
    isMyCoupon = widget.type == myCoupon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle()),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CouponBloc>(
            create: (context) => getIt.get<CouponBloc>(),
          ),
          BlocProvider<CouponPurchasedBloc>(
            create: (context) => getIt.get<CouponPurchasedBloc>(),
          ),
        ],
        child: CouponDetail(
          isMyCoupon: isMyCoupon,
          id: widget.id,
        ),
      ),
    );
  }
}
