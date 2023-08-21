import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_state.dart';
import 'event_tile.dart';

class EventToday extends StatefulWidget {
  final bool isTodayEvent;

  const EventToday({super.key, required this.isTodayEvent});

  @override
  State<EventToday> createState() => _EventTodayState();
}

class _EventTodayState extends State<EventToday> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventDone) {
          final event = state.event!;

          return EventTile(
            isTodayEvent: true,
            headerLabel: 'Today\'s Event',
            image: event.image,
            artist: event.artist,
            timeStart: event.timeStart,
            storeName: event.storeName,
            isFullBook: event.isFullBook == 1,
          );
        }

        if (state is EventError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }

        return const SBLoading();
      },
    );
  }
}
