import 'package:equatable/equatable.dart';

class OperationalHoursEntity extends Equatable {
  final String? day;
  final String? hour;
  final bool? isToday;
  final bool? isOpen;

  const OperationalHoursEntity({
    this.day,
    this.hour,
    this.isToday,
    this.isOpen,
  });

  @override
  List<Object?> get props => [
        day,
        hour,
        isToday,
        isOpen,
      ];
}
