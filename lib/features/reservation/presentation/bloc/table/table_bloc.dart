import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/table.dart';
import '../../../domain/entities/table_floor.dart';
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
  String? _storeImage;
  String? _date;
  String? _dateDisplay;
  String? _event;
  List<TableFloorEntity>? _floors;
  List<List<TableDetailEntity>> _tables = [];

  final List<Map<String, List<TablePosition>>> _tablePosition = [
    {
      'celine': [
        const TablePosition(top: .17, left: .32),
        const TablePosition(top: .2, left: .29),
        const TablePosition(top: .275, left: .32),
        const TablePosition(top: .3, left: .37),
        const TablePosition(top: .3, right: .36),
        const TablePosition(top: .28, right: .3),
        const TablePosition(top: .21, right: .26),
        const TablePosition(top: .18, right: .29),
      ],
      'chanel': [
        const TablePosition(top: .095, left: .24),
        const TablePosition(top: .14, left: .15),
        const TablePosition(top: .2, left: .11),
        const TablePosition(top: .265, left: .13),
        const TablePosition(top: .322, left: .19),
        const TablePosition(top: .365, left: .31),
        const TablePosition(top: .36, right: .305),
        const TablePosition(top: .325, right: .19),
        const TablePosition(top: .21, right: .12),
        const TablePosition(top: .15, right: .15),
      ],
      'tom ford': [
        const TablePosition(top: .04, right: .12),
      ]
    },
    {
      'balenciaga i': [
        const TablePosition(top: .299, left: .188),
        const TablePosition(top: .314, left: .148),
        const TablePosition(top: .335, left: .11),
        const TablePosition(top: .34, left: .166),
        const TablePosition(top: .33, left: .218),
      ],
      'balenciaga ii': [
        const TablePosition(top: .336, right: .205),
        const TablePosition(top: .35, right: .163),
        const TablePosition(top: .336, right: .118),
        const TablePosition(top: .315, right: .12),
        const TablePosition(top: .3, right: .147),
      ],
      'balenciaga iii': [
        const TablePosition(top: .05, left: .35),
        const TablePosition(top: .05, left: .27),
        const TablePosition(top: .05, left: .21),
        const TablePosition(top: .06, left: .16),
        const TablePosition(top: .085, left: .135),
        const TablePosition(top: .115, left: .13),
      ],
      'dior': [
        const TablePosition(top: .336, left: .316),
        const TablePosition(top: .35, left: .425),
        const TablePosition(top: .35, right: .385),
        const TablePosition(top: .336, right: .279),
      ],
      'prada': [
        const TablePosition(top: .185, left: .21),
        const TablePosition(top: .215, left: .21),
        const TablePosition(top: .245, left: .23),
        const TablePosition(top: .23, right: .177),
        const TablePosition(top: .202, right: .17),
      ],
      'ysl': [
        const TablePosition(top: .165, left: .127),
        const TablePosition(top: .22, left: .125),
        const TablePosition(top: .27, left: .17),
        const TablePosition(top: .253, right: .133),
        const TablePosition(top: .183, right: .115),
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
        _tables = [];

        final reservation = TableModel.fromJson(dataState.data!.data);

        _storeId = int.parse(reservation.storeId!);
        _storeName = reservation.storeName;
        _storeImage = reservation.storeImage;
        _date = reservation.date;
        _dateDisplay = reservation.dateDisplay;
        _event = reservation.event;

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
            storeImage: _storeImage,
            date: _date,
            dateDisplay: _dateDisplay,
            event: _event,
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
      storeImage: _storeImage,
      date: _date,
      dateDisplay: _dateDisplay,
      event: _event,
      tables: _tables.elementAt(_tabIndex),
    ));
  }
}
