import '../../domain/entities/operational_hours.dart';

class OperationalHoursModel extends OperationalHoursEntity {
  const OperationalHoursModel({
    String? day,
    String? hour,
    bool? isToday,
    bool? isOpen,
  }) : super(
          day: day,
          hour: hour,
          isToday: isToday,
          isOpen: isOpen,
        );

  factory OperationalHoursModel.fromJson(Map<String, dynamic> data) =>
      OperationalHoursModel(
        day: data['day'],
        hour: data['hour'],
        isToday: data['is_today'],
        isOpen: data['is_open'],
      );
}
