import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:southbank/config/theme/app_theme.dart';

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

        if (state is EventNotFound) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Event',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(Icons.info, color: accentColor),
                        ),
                        const WidgetSpan(child: SizedBox(width: 8.0)),
                        const TextSpan(text: 'There is no event for today')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return const SBLoading();
      },
    );
  }
}
