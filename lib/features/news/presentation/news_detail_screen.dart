import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/news/news_bloc.dart';
import 'widgets/news_detail.dart';

class NewsDetailScreen extends StatefulWidget {
  final String id;

  const NewsDetailScreen({super.key, required this.id});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: BlocProvider<NewsBloc>(
        create: (BuildContext context) => getIt.get<NewsBloc>(),
        child: NewsDetail(
          id: widget.id,
        ),
      ),
    );
  }
}
