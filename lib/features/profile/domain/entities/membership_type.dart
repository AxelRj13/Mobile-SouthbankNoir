import 'package:equatable/equatable.dart';

class MembershipTypeEntity extends Equatable {
  final int? id;
  final String? label;

  const MembershipTypeEntity({this.id, this.label});

  @override
  List<Object?> get props => [id, label];
}
