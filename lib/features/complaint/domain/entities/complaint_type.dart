import 'package:equatable/equatable.dart';

class ComplaintTypeEntity extends Equatable {
  final String? id;
  final String? name;

  const ComplaintTypeEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
