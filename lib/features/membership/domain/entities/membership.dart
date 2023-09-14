import 'package:equatable/equatable.dart';

class MembershipEntity extends Equatable {
  final int? points;
  final int? totalSpent;
  final String? name;
  final int? totalSpentMax;
  final String? diffNextTier;

  const MembershipEntity({
    this.points,
    this.totalSpent,
    this.name,
    this.totalSpentMax,
    this.diffNextTier,
  });

  @override
  List<Object?> get props => [
        points,
        totalSpent,
        name,
        totalSpentMax,
        diffNextTier,
      ];
}
