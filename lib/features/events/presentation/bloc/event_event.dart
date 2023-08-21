abstract class EventEvent {
  const EventEvent();
}

class GetEvents extends EventEvent {
  const GetEvents();
}

class GetEventBySearch extends EventEvent {
  final String query;

  const GetEventBySearch({required this.query});
}

class GetTodayEvent extends EventEvent {
  const GetTodayEvent();
}
