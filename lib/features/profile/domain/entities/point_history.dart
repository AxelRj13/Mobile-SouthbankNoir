import 'package:equatable/equatable.dart';

class PointHistoryEntity extends Equatable {
  final String? title;
  final String? details;
  final String? pointChange;
  final String? latestPoint;
  final String? createdDate;

  const PointHistoryEntity({
    this.title,
    this.details,
    this.pointChange,
    this.latestPoint,
    this.createdDate,
  });

  @override
  List<Object?> get props => [
        title,
        details,
        pointChange,
        latestPoint,
        createdDate,
      ];
}
