import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String? id;
  final String? name;
  final String? artist;
  final String? storeId;
  final String? storeName;
  final String? image;
  final String? dateStart;
  final String? timeStart;
  final String? rsvpDate;
  final String? rsvpDateDisplay;
  final int? isFullBook;

  const EventEntity({
    this.id,
    this.name,
    this.artist,
    this.storeId,
    this.storeName,
    this.image,
    this.dateStart,
    this.timeStart,
    this.rsvpDate,
    this.rsvpDateDisplay,
    this.isFullBook,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        artist,
        storeId,
        storeName,
        image,
        dateStart,
        timeStart,
        rsvpDate,
        rsvpDateDisplay,
        isFullBook,
      ];
}
