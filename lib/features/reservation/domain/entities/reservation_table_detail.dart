import 'package:equatable/equatable.dart';

class ReservationTableDetailEntity extends Equatable {
  final String? tableName;
  final String? capacity;
  final String? total;
  final String? minimumSpend;

  const ReservationTableDetailEntity({
    this.tableName,
    this.capacity,
    this.total,
    this.minimumSpend,
  });

  @override
  List<Object?> get props => [
        tableName,
        capacity,
        total,
        minimumSpend,
      ];
}
