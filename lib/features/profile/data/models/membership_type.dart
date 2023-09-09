import '../../domain/entities/membership_type.dart';

class MembershipTypeModel extends MembershipTypeEntity {
  const MembershipTypeModel({
    int? id,
    String? label,
  }) : super(id: id, label: label);
}
