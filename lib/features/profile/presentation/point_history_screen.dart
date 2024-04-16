import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/point/point_bloc.dart';
import 'bloc/point/point_event.dart';
import 'widgets/point_history_widget.dart';

class PointHistoryScreen extends StatefulWidget {
  const PointHistoryScreen({super.key});

  @override
  State<PointHistoryScreen> createState() => _PointHistoryScreenState();
}

class _PointHistoryScreenState extends State<PointHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PointBloc>(
      create: (context) => getIt.get<PointBloc>()..add(const GetPointHistory()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Point History'),
        ),
        body: const PointHistoryWidget(),
      ),
    );
  }
}
