import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/event.dart';
import '../../domain/usecases/get_event.dart';
import '../../domain/usecases/get_events.dart';
import '../../domain/usecases/get_today_event.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEventUseCase _getEventUseCase;
  final GetEventsUseCase _getEventsUseCase;
  final GetTodayEventUseCase _getTodayEventUseCase;

  List<EventModel> _events = [];

  EventBloc(
    this._getEventUseCase,
    this._getEventsUseCase,
    this._getTodayEventUseCase,
  ) : super(const EventLoading()) {
    on<GetEvent>(onGetEvent);
    on<GetEvents>(onGetEvents);
    on<GetEventBySearch>(onGetEventBySearch);
    on<GetTodayEvent>(onGetTodayEvent);
  }

  void onGetEvent(
    GetEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(const EventLoading());

    final dataState = await _getEventUseCase(params: event.id);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final event = EventModel.fromJson(dataState.data!.data);

        emit(EventDone(event: event));
      } else {
        emit(const EventNotFound());
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(EventError(dataState.error!));
    }
  }

  void onGetEvents(
    GetEvents event,
    Emitter<EventState> emit,
  ) async {
    emit(const EventLoading());

    final dataState = await _getEventsUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      print(dataState.data!);

      if (status == 1) {
        _events = (dataState.data!.data as List)
            .map(
              (item) => EventModel.fromJson(item),
            )
            .toList();

        emit(EventsDone(events: _events));
      } else {
        emit(const EventNotFound());
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(EventError(dataState.error!));
    }
  }

  void onGetEventBySearch(
    GetEventBySearch event,
    Emitter<EventState> emit,
  ) async {
    emit(const EventLoading());

    final eventFounds = _events
        .where(
          (e) =>
              e.name!.toLowerCase().contains(
                    event.query.toLowerCase(),
                  ) ||
              e.artist!.toLowerCase().contains(
                    event.query.toLowerCase(),
                  ),
        )
        .toList();

    emit(EventsDone(events: eventFounds));
  }

  void onGetTodayEvent(
    GetTodayEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(const EventLoading());

    final dataState = await _getTodayEventUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final todayEvent = (dataState.data!.data as List)
            .map(
              (item) => EventModel.fromJson(item),
            )
            .toList();

        emit(EventsDone(events: todayEvent));
      } else {
        emit(const EventNotFound());
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(EventError(dataState.error!));
    }
  }
}
