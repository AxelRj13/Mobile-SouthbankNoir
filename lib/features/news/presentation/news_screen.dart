import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../core/components/loading.dart';
import 'bloc/news/remote/news_bloc.dart';
import 'bloc/news/remote/news_state.dart';
import 'widgets/news_tile.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

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
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    TabBar tabBar() {
      return TabBar(
        controller: _tabController,
        indicatorPadding: const EdgeInsets.only(left: 15.0, right: 15.0),
        indicatorColor: accentColor,
        tabs: const <Widget>[
          Tab(
            text: 'News',
          ),
          Tab(
            text: 'Promo',
          ),
        ],
      );
    }

    return AppBar(
      title: const Text('News & Promo'),
      bottom: PreferredSize(
        preferredSize: tabBar().preferredSize,
        child: Material(
          color: backgroundColor,
          child: tabBar(),
        ),
      ),
    );
  }

  _buildBody() {
    return TabBarView(
      controller: _tabController,
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        Center(
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (_, state) {
              if (state is NewsLoading) {
                return const SBLoading();
              }
              if (state is NewsError) {
                return const Center(
                  child: Icon(Icons.refresh),
                );
              }
              if (state is NewsDone) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return NewsTileWidget(news: state.news![index]);
                    // ListTile(
                    //   title: Stack(
                    //     children: [
                    //       Image.asset(
                    //         "assets/Rectangle 4166.png",
                    //         width: 100,
                    //         height: 100,
                    //       ),
                    //       const Text(
                    //         "We’re HIRING at Southbank Noir for some positions",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    // const Text(
                    //   "Posted 01 March 2023",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    //       Stack(
                    //         children: [
                    //           Container(
                    //             width: 94,
                    //             height: 23,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               color: const Color(0xfff3a837),
                    //             ),
                    //           ),
                    //           const Text(
                    //             "See More >",
                    //             style: TextStyle(
                    //               fontSize: 12,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // );
                  },
                  itemCount: state.news!.length,
                );
              }
              return const SizedBox();
            },
          ),
        ),
        const Center(
          child: Text("It's rainy here"),
        ),
      ],
    );
  }
}
