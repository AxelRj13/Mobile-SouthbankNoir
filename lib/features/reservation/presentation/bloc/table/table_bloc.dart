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
  final List<List<TableDetailEntity>> _tables = [];

  final List<Map<String, List<TablePosition>>> _tablePosition = [
    {
      'celine': [
        const TablePosition(top: .34, left: .33),
        const TablePosition(top: .40, left: .29),
        const TablePosition(top: .525, left: .32),
        const TablePosition(top: .57, left: .38),
        const TablePosition(top: .57, right: .37),
        const TablePosition(top: .53, right: .31),
        const TablePosition(top: .42, right: .27),
        const TablePosition(top: .36, right: .30),
      ],
      'chanel': [
        const TablePosition(top: .2, left: .25),
        const TablePosition(top: .285, left: .16),
        const TablePosition(top: .395, left: .115),
        const TablePosition(top: .51, left: .13),
        const TablePosition(top: .612, left: .21),
        const TablePosition(top: .685, left: .325),
        const TablePosition(top: .675, right: .325),
        const TablePosition(top: .615, right: .205),
        const TablePosition(top: .415, right: .13),
        const TablePosition(top: .31, right: .165),
      ],
      'tom ford': [
        const TablePosition(top: .12, right: .13),
      ]
    },
    {
      'balenciaga i': [
        const TablePosition(top: .611, left: .19),
        const TablePosition(top: .637, left: .15),
        const TablePosition(top: .666, left: .114),
        const TablePosition(top: .672, left: .166),
        const TablePosition(top: .657, left: .218),
      ],
      'balenciaga ii': [
        const TablePosition(top: .67, right: .214),
        const TablePosition(top: .688, right: .166),
        const TablePosition(top: .67, right: .12),
        const TablePosition(top: .631, right: .12),
        const TablePosition(top: .6, right: .153),
      ],
      'balenciaga iii': [
        const TablePosition(top: .15, left: .363),
        const TablePosition(top: .15, left: .285),
        const TablePosition(top: .15, left: .216),
        const TablePosition(top: .17, left: .163),
        const TablePosition(top: .215, left: .135),
        const TablePosition(top: .265, left: .13),
      ],
      'dior': [
        const TablePosition(top: .67, left: .326),
        const TablePosition(top: .7, left: .44),
        const TablePosition(top: .7, right: .405),
        const TablePosition(top: .67, right: .295),
      ],
      'prada': [
        const TablePosition(top: .393, left: .21),
        const TablePosition(top: .447, left: .21),
        const TablePosition(top: .505, left: .23),
        const TablePosition(top: .477, right: .177),
        const TablePosition(top: .423, right: .17),
      ],
      'ysl': [
        const TablePosition(top: .355, left: .127),
        const TablePosition(top: .457, left: .125),
        const TablePosition(top: .551, left: .17),
        const TablePosition(top: .515, right: .133),
        const TablePosition(top: .39, right: .115),
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

    print(tableRequest);

    final dataState = await _getTablesUseCase(params: tableRequest);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        print(dataState.data!.data);
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

              print('${tableDetail.id} ${tableDetail.isAvailable}');

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
