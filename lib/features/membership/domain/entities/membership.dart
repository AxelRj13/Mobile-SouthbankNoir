import 'package:equatable/equatable.dart';

class MembershipEntity extends Equatable {
  final int? points;
  final int? totalSpent;
  final String? name;
  final int? totalSpentMax;
  final String? diffNextTier;
  final int? totalTiers;
  final String? privacyPolicyUrl;
  final String? tncUrl;
  final String? appVersion;

  const MembershipEntity({
    this.points,
    this.totalSpent,
    this.name,
    this.totalSpentMax,
    this.diffNextTier,
    this.totalTiers,
    this.privacyPolicyUrl,
    this.tncUrl,
    this.appVersion,
  });

  @override
  List<Object?> get props => [
        points,
        totalSpent,
        name,
        totalSpentMax,
        diffNextTier,
        totalTiers,
        privacyPolicyUrl,
        tncUrl,
        appVersion,
      ];
}
