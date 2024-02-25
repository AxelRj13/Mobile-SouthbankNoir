import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/image_header.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/error/general_error.dart';
import '../../../../core/error/not_found.dart';
import '../../data/models/news.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';

class NewsDetail extends StatefulWidget {
  final String id;

  const NewsDetail({super.key, required this.id});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  Widget buildNewsArticle(NewsModel news) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.title!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, color: Colors.grey, size: 20.0),
              const SizedBox(width: 5.0),
              Text(
                'Posted on ${news.createdAt!}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Text(news.description!),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsBloc>().add(GetNews(id: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(child: SBLoading());
        }

        if (state is NewsError) {
          return const Center(child: GeneralErrorWidget(isDetail: true));
        }

        if (state is NewsDone) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SBImageHeader(image: state.news!.image),
                buildNewsArticle(state.news!),
              ],
            ),
          );
        }

        return const Center(child: NotFoundWidget());
      },
    );
  }
}
