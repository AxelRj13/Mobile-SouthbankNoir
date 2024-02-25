import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/app_theme.dart';
import '../../injection_container.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';
import '../../features/news/presentation/bloc/news_event.dart';
import '../../features/news/presentation/bloc/news_state.dart';
import '../../features/news/presentation/widgets/tab_news.dart';
import '../../features/promo/presentation/bloc/promo/promo_bloc.dart';
import '../../features/promo/presentation/bloc/promo/promo_event.dart';
import '../../features/promo/presentation/bloc/promo/promo_state.dart';
import '../../features/promo/presentation/widgets/tab_promo.dart';
import '../components/refresh_indicator.dart';

class NewsPromoScreen extends StatelessWidget {
  const NewsPromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(create: (context) => getIt.get<NewsBloc>()..add(const GetNewsList())),
        BlocProvider<PromoBloc>(create: (context) => getIt.get<PromoBloc>()..add(const GetPromoList())),
      ],
      child: const NewsPromoTabView(),
    );
  }
}

class NewsPromoTabView extends StatefulWidget {
  const NewsPromoTabView({super.key});

  @override
  State<NewsPromoTabView> createState() => _NewsPromoTabViewState();
}

class _NewsPromoTabViewState extends State<NewsPromoTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _listTabs = [
    const Tab(text: 'News'),
    const Tab(text: 'Promo'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
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
          title: const Text('News & Promo'),
        ),
        body: Column(
          children: [
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
                  context.read<NewsBloc>().add(const GetNewsList());
                  context.read<PromoBloc>().add(const GetPromoList());
                },
                items: [
                  Center(
                    child: [
                      BlocBuilder<NewsBloc, NewsState>(
                        builder: (_, state) {
                          return TabNews(state: state);
                        },
                      ),
                      BlocBuilder<PromoBloc, PromoState>(
                        builder: (_, state) {
                          return TabPromo(state: state);
                        },
                      ),
                    ][_tabController.index],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
