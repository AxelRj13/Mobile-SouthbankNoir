import '../../domain/entities/point_history.dart';

class PointHistoryModel extends PointHistoryEntity {
  const PointHistoryModel({
    String? title,
    String? details,
    String? tableInfo,
    String? pointChange,
    String? latestPoint,
    String? createdDate,
  }) : super(
          title: title,
          details: details,
          tableInfo: tableInfo,
          pointChange: pointChange,
          latestPoint: latestPoint,
          createdDate: createdDate,
        );

  factory PointHistoryModel.fromJson(Map<String, dynamic> data) => PointHistoryModel(
        title: data['title'],
        details: data['details'],
        tableInfo: data['table_info'],
        pointChange: data['point_change'],
        latestPoint: data['latest_point'],
        createdDate: data['created_date'],
      );
}
