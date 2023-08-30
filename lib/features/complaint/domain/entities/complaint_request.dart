import 'package:equatable/equatable.dart';

class ComplaintRequest extends Equatable {
  final String type;
  final String? date;
  final String store;
  final String description;

  const ComplaintRequest({
    required this.type,
    this.date,
    required this.store,
    required this.description,
  });

  @override
  List<Object?> get props => [type, date, store, description];
}
