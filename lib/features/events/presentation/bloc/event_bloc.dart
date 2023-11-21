import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/event.dart';
import '../../domain/usecases/get_event.dart';
import '../../domain/usecases/get_today_event.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEventUseCase _getEventUseCase;
  final GetTodayEventUseCase _getTodayEventUseCase;

  List<EventModel> _events = [];

  EventBloc(
    this._getEventUseCase,
    this._getTodayEventUseCase,
  ) : super(const EventLoading()) {
    on<GetEvents>(onGetEvents);
    on<GetEventBySearch>(onGetEventBySearch);
    on<GetTodayEvent>(onGetTodayEvent);
  }

  void onGetEvents(
    GetEvents event,
    Emitter<EventState> emit,
  ) async {
    final dataState = await _getEventUseCase();

    if (dataState is DataSuccess) {
      _events = (dataState.data!.data as List).map((item) => EventModel.fromJson(item)).toList();

      emit(
        EventsDone(
          events: _events,
        ),
      );
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

    emit(
      EventsDone(
        events: eventFounds,
      ),
    );
  }

  void onGetTodayEvent(
    GetTodayEvent event,
    Emitter<EventState> emit,
  ) async {
    final dataState = await _getTodayEventUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final todayEvent = (dataState.data!.data as List)
            .map(
              (item) => EventModel.fromJson(item),
            )
            .toList();

        emit(
          EventsDone(
            events: todayEvent,
          ),
        );
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
