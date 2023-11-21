import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/table_detail.dart';

abstract class TableState extends Equatable {
  final int? tabIndex;
  final int? storeId;
  final String? storeName;
  final String? storeImage;
  final String? date;
  final String? dateDisplay;
  final int? tableId;
  final String? event;
  final List<TableDetailEntity>? tables;
  final DioException? error;

  const TableState({
    this.tabIndex,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.date,
    this.dateDisplay,
    this.tableId,
    this.event,
    this.tables,
    this.error,
  });

  @override
  List<Object> get props => [
        tabIndex!,
        storeId!,
        storeName!,
        storeImage!,
        date!,
        dateDisplay!,
        tableId!,
        event!,
        tables!,
        error!,
      ];
}

class TableInitial extends TableState {
  const TableInitial({
    required int tabIndex,
    int? storeId,
    String? storeName,
    String? storeImage,
    String? date,
    String? dateDisplay,
    String? event,
    List<TableDetailEntity>? tables,
  }) : super(
          tabIndex: tabIndex,
          storeId: storeId,
          storeName: storeName,
          storeImage: storeImage,
          date: date,
          dateDisplay: dateDisplay,
          event: event,
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
