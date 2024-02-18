import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/components/refresh_indicator.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_event.dart';
import '../bloc/event_state.dart';
import 'event_tile.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({super.key});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return SBRefreshIndicator(
      onRefresh: () async {
        context.read<EventBloc>().add(const GetEvents());
      },
      items: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (value) => context.read<EventBloc>().add(
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
        BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventsDone) {
              return state.events!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10.0),
                      itemCount: state.events!.length,
                      itemBuilder: (context, index) {
                        final event = state.events![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: EventTile(
                            isTodayEvent: false,
                            id: event.id,
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
                  : const Center(child: Text('Events not found'));
            }

            if (state is EventNotFound) {
              return const Center(
                child: Text('Events not found'),
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
      ],
    );
  }
}
