import '../../domain/entities/complaint_type.dart';

class ComplaintTypeModel extends ComplaintTypeEntity {
  const ComplaintTypeModel({
    String? id,
    String? name,
  }) : super(
          id: id,
          name: name,
        );

  factory ComplaintTypeModel.fromJson(Map<String, dynamic> data) =>
      ComplaintTypeModel(
        id: data['id'],
        name: data['name'],
      );
}
