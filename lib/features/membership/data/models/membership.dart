import '../../domain/entities/membership.dart';

class MembershipModel extends MembershipEntity {
  const MembershipModel({
    int? points,
    int? totalSpent,
    String? name,
    int? totalSpentMax,
    String? diffNextTier,
    int? totalTiers,
  }) : super(
          points: points,
          totalSpent: totalSpent,
          name: name,
          totalSpentMax: totalSpentMax,
          diffNextTier: diffNextTier,
          totalTiers: totalTiers,
        );

  factory MembershipModel.fromJson(Map<String, dynamic> data) =>
      MembershipModel(
          points: data['points'],
          totalSpent: data['total_spent'],
          name: data['name'],
          totalSpentMax: data['total_spent_max'],
          diffNextTier: data['diff_next_tier'],
          totalTiers: data['total_tiers']);
}
