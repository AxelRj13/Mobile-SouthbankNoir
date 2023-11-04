import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/reservation.dart';
import '../../../domain/entities/floor.dart';
import '../../../domain/entities/table_detail.dart';
import '../../../domain/entities/table_position.dart';
import '../../../domain/entities/table_request.dart';
import '../../../domain/usecases/get_tables.dart';
import 'table_event.dart';
import 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final GetTablesUseCase _getTablesUseCase;

  int _tabIndex = 0;
  int? _storeId;
  String? _storeName;
  String? _date;
  String? _dateDisplay;
  List<FloorEntity>? _floors;
  List<List<TableDetailEntity>> _tables = [];

  final List<Map<String, List<TablePosition>>> _tablePosition = [
    {
      'celine': [
        const TablePosition(top: .3, left: .3),
        const TablePosition(top: .4, left: .2),
        const TablePosition(top: .55, left: .2),
        const TablePosition(top: .65, left: .3),
        const TablePosition(top: .65, right: .3),
        const TablePosition(top: .55, right: .2),
        const TablePosition(top: .4, right: .2),
        const TablePosition(top: .3, right: .3),
      ],
      'chanel': [
        const TablePosition(top: .2, left: .2),
        const TablePosition(top: .3, left: .13),
        const TablePosition(top: .4, left: .03),
        const TablePosition(top: .55, left: .03),
        const TablePosition(top: .65, left: .13),
        const TablePosition(top: .75, left: .2),
        const TablePosition(top: .65, right: .13),
        const TablePosition(top: .55, right: .03),
        const TablePosition(top: .4, right: .03),
        const TablePosition(top: .3, right: .13),
      ],
      'tom ford': [
        const TablePosition(top: .12, right: .12),
      ]
    },
    {
      'balenciaga i': [
        const TablePosition(top: .7, left: .15),
        const TablePosition(top: .78, left: .08),
        const TablePosition(top: .86, left: .01),
        const TablePosition(top: .86, left: .15),
        const TablePosition(top: .78, left: .22),
      ],
      'balenciaga ii': [
        const TablePosition(top: .78, right: .22),
        const TablePosition(top: .86, right: .12),
        const TablePosition(top: .78, right: .01),
        const TablePosition(top: .70, right: .01),
        const TablePosition(top: .65, right: .12),
      ],
      'balenciaga iii': [
        const TablePosition(top: .12, left: .42),
        const TablePosition(top: .12, left: .32),
        const TablePosition(top: .12, left: .22),
        const TablePosition(top: .16, left: .1),
        const TablePosition(top: .24, left: .07),
        const TablePosition(top: .32, left: .1),
      ],
      'dior': [
        const TablePosition(top: .75, left: .32),
        const TablePosition(top: .78, left: .42),
        const TablePosition(top: .78, right: .42),
        const TablePosition(top: .75, right: .32),
      ],
      'prada': [
        const TablePosition(top: .42, left: .2),
        const TablePosition(top: .5, left: .17),
        const TablePosition(top: .58, left: .2),
        const TablePosition(top: .54, right: .17),
        const TablePosition(top: .46, right: .17),
      ],
      'ysl': [
        const TablePosition(top: .4, left: .1),
        const TablePosition(top: .5, left: .07),
        const TablePosition(top: .6, left: .1),
        const TablePosition(top: .55, right: .07),
        const TablePosition(top: .45, right: .07),
      ]
    },
  ];

  TableBloc(
    this._getTablesUseCase,
  ) : super(const TableLoading()) {
    on<TabChange>(onTabChange);
    on<GetTables>(onGetTables);
  }

  void onGetTables(
    GetTables event,
    Emitter<TableState> emit,
  ) async {
    emit(const TableLoading());

    final tableRequest = TableRequest(
      storeId: '1',
      date: event.date,
    );

    final dataState = await _getTablesUseCase(params: tableRequest);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final reservation = ReservationModel.fromJson(dataState.data!.data);

        _storeId = int.parse(reservation.storeId!);
        _storeName = reservation.storeName;
        _date = reservation.date;
        _dateDisplay = reservation.dateDisplay;

        _floors = reservation.floors!;

        _floors!.asMap().forEach((key, floor) {
          final listTables = <TableDetailEntity>[];
          final floorTablePosition = _tablePosition.elementAt(key);
          final floorTable = floor.table;

          floorTable!.asMap().forEach((key, table) {
            final tablesPosition = floorTablePosition[table.name!.toLowerCase()];
            final tables = table.tables;

            tables!.asMap().forEach((key, tableDetail) {
              final tablePosition = tablesPosition!.elementAt(key);

              final tableDetailObject = TableDetailEntity(
                id: tableDetail.id,
                tableName: table.name!,
                tableNo: tableDetail.tableNo,
                capacity: tableDetail.capacity,
                downPayment: tableDetail.downPayment,
                downPaymentNumber: tableDetail.downPaymentNumber,
                minimumSpend: tableDetail.minimumSpend,
                isAvailable: tableDetail.isAvailable,
                top: tablePosition.top,
                right: tablePosition.right,
                bottom: tablePosition.bottom,
                left: tablePosition.left,
              );

              listTables.add(tableDetailObject);
            });
          });

          _tables.add(listTables);
        });

        emit(
          TableInitial(
            tabIndex: _tabIndex,
            storeId: _storeId,
            storeName: _storeName,
            date: _date,
            dateDisplay: _dateDisplay,
            tables: _tables.elementAt(_tabIndex),
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(TableError(dataState.error!));
    }
  }

  void onTabChange(
    TabChange event,
    Emitter<TableState> emit,
  ) {
    emit(const TableLoading());

    _tabIndex = event.tabIndex;

    emit(TableInitial(
      tabIndex: _tabIndex,
      storeId: _storeId,
      storeName: _storeName,
      date: _date,
      dateDisplay: _dateDisplay,
      tables: _tables.elementAt(_tabIndex),
    ));
  }
}
