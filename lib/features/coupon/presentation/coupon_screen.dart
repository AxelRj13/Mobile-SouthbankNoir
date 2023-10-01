import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/coupon/coupon_bloc.dart';
import 'bloc/coupon/coupon_event.dart';
import 'widgets/coupon_tab_view.dart';

class CouponScreen extends StatelessWidget {
  final String type;

  const CouponScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CouponBloc>(
      create: (context) => getIt.get<CouponBloc>()..add(const GetCoupons()),
      child: CouponTabView(type: type),
    );
  }
}
