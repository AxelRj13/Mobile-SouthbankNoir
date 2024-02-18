import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/event_bloc.dart';
import 'bloc/event_event.dart';
import 'widgets/event_widget.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventBloc>(
      create: (BuildContext context) => getIt.get<EventBloc>()..add(const GetEvents()),
      child: const EventWidget(),
    );
  }
}
