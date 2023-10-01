import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/constants.dart';
import 'coupon_point_card.dart';
import 'tab_coupons.dart';
import 'tab_my_coupons.dart';

class CouponTabView extends StatefulWidget {
  final String type;

  const CouponTabView({super.key, required this.type});

  @override
  State<CouponTabView> createState() => _CouponTabViewState();
}

class _CouponTabViewState extends State<CouponTabView> {
  int initialIndex = 0;

  final List<Widget> _listTabs = [
    const Tab(text: 'Browse Coupons'),
    const Tab(text: 'My Coupons'),
  ];

  final List<Widget> _listTabViews = [
    const TabCoupons(),
    const TabMyCoupons(),
  ];

  @override
  void initState() {
    super.initState();
    initialIndex = widget.type == buyCoupon ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: _listTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coupons'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CouponPointCard(),
            TabBar(
              indicatorPadding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              indicatorColor: accentColor,
              tabs: _listTabs,
            ),
            Expanded(
              child: TabBarView(
                children: _listTabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
