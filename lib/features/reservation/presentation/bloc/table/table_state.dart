import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/table_detail.dart';

abstract class TableState extends Equatable {
  final int? tabIndex;
  final int? storeId;
  final String? storeName;
  final String? date;
  final String? dateDisplay;
  final int? tableId;
  final List<TableDetailEntity>? tables;
  final DioException? error;

  const TableState({
    this.tabIndex,
    this.storeId,
    this.storeName,
    this.date,
    this.dateDisplay,
    this.tableId,
    this.tables,
    this.error,
  });

  @override
  List<Object> get props => [
        tabIndex!,
        storeId!,
        storeName!,
        date!,
        dateDisplay!,
        tableId!,
        tables!,
        error!,
      ];
}

class TableInitial extends TableState {
  const TableInitial({
    required int tabIndex,
    int? storeId,
    String? storeName,
    String? date,
    String? dateDisplay,
    List<TableDetailEntity>? tables,
  }) : super(
          tabIndex: tabIndex,
          storeId: storeId,
          storeName: storeName,
          date: date,
          dateDisplay: dateDisplay,
          tables: tables,
        );
}

class TableLoading extends TableState {
  const TableLoading();
}

class TableError extends TableState {
  const TableError(
    DioException error,
  ) : super(
          error: error,
        );
}
