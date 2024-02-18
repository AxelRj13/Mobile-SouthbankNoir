import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/event_bloc.dart';
import 'widgets/event_detail.dart';

class EventDetailScreen extends StatefulWidget {
  final String id;

  const EventDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
      ),
      body: SafeArea(
        child: BlocProvider<EventBloc>(
          create: (BuildContext context) => getIt.get<EventBloc>(),
          child: EventDetail(
            id: widget.id,
          ),
        ),
      ),
    );
  }
}
