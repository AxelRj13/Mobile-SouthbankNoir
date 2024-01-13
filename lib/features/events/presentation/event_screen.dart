import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/loading.dart';
import '../../../injection_container.dart';
import 'bloc/event_bloc.dart';
import 'bloc/event_event.dart';
import 'bloc/event_state.dart';
import 'widgets/event_tile.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventBloc>(
      create: (BuildContext context) => getIt.get<EventBloc>()
        ..add(
          const GetEvents(),
        ),
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventsDone) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) => BlocProvider.of<EventBloc>(context).add(
                      GetEventBySearch(
                        query: value,
                      ),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: state.events!.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(10.0),
                          itemCount: state.events!.length,
                          itemBuilder: (context, index) {
                            final event = state.events![index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: EventTile(
                                isTodayEvent: false,
                                headerLabel: event.dateStart,
                                image: event.image,
                                artist: event.artist,
                                timeStart: event.timeStart,
                                storeName: event.storeName,
                                rsvpDate: event.rsvpDate,
                                isFullBook: event.isFullBook == 1,
                              ),
                            );
                          },
                        )
                      : const Center(child: Text('Events not found')),
                ),
              ],
            );
          }

          if (state is EventError) {
            return const Center(
              child: Icon(Icons.refresh),
            );
          }

          return const Center(
            child: SBLoading(),
          );
        },
      ),
    );
  }
}
