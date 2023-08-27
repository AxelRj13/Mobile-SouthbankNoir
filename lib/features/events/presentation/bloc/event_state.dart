import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/event.dart';

abstract class EventState extends Equatable {
  final EventModel? event;
  final List<EventModel>? events;
  final DioException? error;

  const EventState({this.event, this.events, this.error});

  @override
  List<Object> get props => [events!, error!];
}

class EventLoading extends EventState {
  const EventLoading();
}

class EventsDone extends EventState {
  const EventsDone(List<EventModel> events) : super(events: events);
}

class EventDone extends EventState {
  const EventDone(EventModel event) : super(event: event);
}

class EventNotFound extends EventState {
  const EventNotFound();
}

class EventError extends EventState {
  const EventError(DioException error) : super(error: error);
}
