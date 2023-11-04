import 'package:equatable/equatable.dart';

class TableRequest extends Equatable {
  final String storeId;
  final String date;

  const TableRequest({
    required this.storeId,
    required this.date,
  });

  @override
  List<Object?> get props => [
        storeId,
        date,
      ];
}
