import '../../domain/entities/event.dart';

class EventModel extends EventEntity {
  const EventModel({
    String? id,
    String? name,
    String? artist,
    String? storeId,
    String? storeName,
    String? image,
    String? dateStart,
    String? timeStart,
    String? rsvpDate,
    int? isFullBook,
  }) : super(
          id: id,
          name: name,
          artist: artist,
          storeId: storeId,
          storeName: storeName,
          image: image,
          dateStart: dateStart,
          timeStart: timeStart,
          rsvpDate: rsvpDate,
          isFullBook: isFullBook,
        );

  factory EventModel.fromJson(Map<String, dynamic> data) => EventModel(
        id: data['id'],
        name: data['name'],
        artist: data['artist'],
        storeId: data['store_id'],
        storeName: data['store_name'],
        image: data['image'],
        dateStart: data['date_start'],
        timeStart: data['time_start'],
        rsvpDate: data['reservation_date'],
        isFullBook: data['is_fully_booked'],
      );
}
