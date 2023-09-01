import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading.dart';
import '../bloc/news/news_bloc.dart';
import '../bloc/news/news_state.dart';
import 'news_tile.dart';

class TabNews extends StatefulWidget {
  const TabNews({super.key});

  @override
  State<TabNews> createState() => _TabNewsState();
}

class _TabNewsState extends State<TabNews> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (_, state) {
          if (state is NewsLoading) {
            return const SBLoading();
          }

          if (state is NewsError) {
            return const Icon(Icons.refresh);
          }

          if (state is NewsListDone) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return NewsTileWidget(news: state.newsList![index]);
              },
              itemCount: state.newsList!.length,
            );
          }

          return const Text('No data');
        },
      ),
    );
  }
}
