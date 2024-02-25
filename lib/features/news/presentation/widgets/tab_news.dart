import 'package:flutter/material.dart';
import 'package:southbank/core/error/general_error.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/error/not_found.dart';
import '../bloc/news_state.dart';
import 'news_tile.dart';

class TabNews extends StatefulWidget {
  final NewsState state;

  const TabNews({
    super.key,
    required this.state,
  });

  @override
  State<TabNews> createState() => _TabNewsState();
}

class _TabNewsState extends State<TabNews> {
  @override
  Widget build(BuildContext context) {
    if (widget.state is NewsLoading) {
      return const SBLoading();
    }

    if (widget.state is NewsError) {
      return const GeneralErrorWidget();
    }

    if (widget.state is NewsListDone) {
      return Column(
        children: widget.state.newsList!
            .map(
              (news) => NewsTileWidget(news: news),
            )
            .toList(),
      );
    }

    return const NotFoundWidget();
  }
}
