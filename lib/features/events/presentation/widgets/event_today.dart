import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';
import '../../data/models/event.dart';
import 'event_tile.dart';
import 'today_event_title.dart';

class EventToday extends StatefulWidget {
  final List<EventModel>? events;

  const EventToday({
    super.key,
    this.events,
  });

  @override
  State<EventToday> createState() => _EventTodayState();
}

class _EventTodayState extends State<EventToday> {
  Widget _buildEventToday() {
    if (widget.events != null) {
      return Column(
        children: [
          const TodayEventTitle(),
          ...widget.events!.map(
            (event) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: EventTile(
                isTodayEvent: true,
                headerLabel: 'Today\'s Event',
                image: event.image,
                artist: event.artist,
                timeStart: event.timeStart,
                storeName: event.storeName,
                rsvpDate: event.rsvpDate,
                isFullBook: event.isFullBook == 1,
              ),
            ),
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TodayEventTitle(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.18,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: _buildEventToday(),
    );
  }
}
