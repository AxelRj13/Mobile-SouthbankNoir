import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/refresh_indicator.dart';
import '../../../../core/constants/constants.dart';
import '../bloc/coupon/coupon_bloc.dart';
import '../bloc/coupon/coupon_event.dart';
import '../bloc/coupon/coupon_state.dart';
import 'coupon_point_card.dart';
import 'tab_coupons.dart';
import 'tab_my_coupons.dart';

class CouponTabView extends StatefulWidget {
  final String type;

  const CouponTabView({super.key, required this.type});

  @override
  State<CouponTabView> createState() => _CouponTabViewState();
}

class _CouponTabViewState extends State<CouponTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _listTabs = [
    const Tab(text: 'Browse Coupons'),
    const Tab(text: 'My Coupons'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.type == buyCoupon ? 0 : 1,
      length: _listTabs.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _listTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coupons'),
        ),
        body: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CouponPointCard(),
              ],
            ),
            TabBar(
              indicatorPadding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              indicatorColor: accentColor,
              controller: _tabController,
              tabs: _listTabs,
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: SBRefreshIndicator(
                onRefresh: () async {
                  context.read<CouponBloc>().add(const GetCoupons());
                },
                items: [
                  Center(
                    child: [
                      BlocBuilder<CouponBloc, CouponState>(
                        builder: (_, state) {
                          return Center(
                            child: TabCoupons(
                              state: state,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<CouponBloc, CouponState>(
                        builder: (_, state) {
                          return Center(
                            child: TabMyCoupons(
                              state: state,
                            ),
                          );
                        },
                      )
                    ][_tabController.index],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
