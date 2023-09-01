import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../injection_container.dart';
import 'bloc/news/news_bloc.dart';
import 'bloc/news/news_event.dart';
import 'widgets/tab_news.dart';
import 'widgets/tab_promo.dart';

class NewsPromoScreen extends StatefulWidget {
  const NewsPromoScreen({super.key});

  @override
  State<NewsPromoScreen> createState() => _NewsPromoScreenState();
}

class _NewsPromoScreenState extends State<NewsPromoScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  TabBar buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorPadding: const EdgeInsets.only(left: 15.0, right: 15.0),
      indicatorColor: accentColor,
      tabs: const <Widget>[
        Tab(text: 'News'),
        Tab(text: 'Promo'),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News & Promo'),
        bottom: PreferredSize(
          preferredSize: buildTabBar().preferredSize,
          child: Material(
            color: backgroundColor,
            child: buildTabBar(),
          ),
        ),
      ),
      body: BlocProvider<NewsBloc>(
        create: (BuildContext context) =>
            getIt.get<NewsBloc>()..add(const GetNewsList()),
        child: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: const <Widget>[
            TabNews(),
            TabPromo(),
          ],
        ),
      ),
    );
  }
}
