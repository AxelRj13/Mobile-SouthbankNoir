import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/dialog.dart';
import '../../../../core/components/loading.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/table_detail.dart';
import '../bloc/reservation/reservation_bloc.dart';
import '../bloc/reservation/reservation_event.dart';
import '../bloc/reservation/reservation_state.dart';
import '../bloc/table/table_bloc.dart';
import '../bloc/table/table_event.dart';
import 'reservation_legend.dart';

class ReservationWidget extends StatefulWidget {
  final int tabIndex;
  final int storeId;
  final String storeName;
  final String date;
  final String dateDisplay;
  final List<TableDetailEntity> tables;

  const ReservationWidget({
    super.key,
    required this.tabIndex,
    required this.storeId,
    required this.storeName,
    required this.date,
    required this.dateDisplay,
    required this.tables,
  });

  @override
  State<ReservationWidget> createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  int? _selectedTableNo;
  TableDetailEntity? _selectedTable;

  void selectTable({
    required int storeId,
    required String date,
    required TableDetailEntity table,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) => BlocProvider.value(
        value: getIt.get<ReservationBloc>(),
        child: BlocListener<ReservationBloc, ReservationState>(
          listener: (context, state) async {
            if (state is ReservationBook) {
              await basicDialog(
                context,
                state.message!.title,
                state.message!.message,
              );

              if (state.message!.status) {
                router.goNamed(
                  'confirmation',
                  pathParameters: {'bookingId': state.bookingId!},
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  table.tableName!.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  table.tableNo!,
                  style: Theme.of(context).textTheme.titleLarge!,
                ),
                const SizedBox(height: 10.0),
                Text(
                  '*Min Spend. ${table.minimumSpend!}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 15.0),
                buildBottomSheetInformation(
                  icon: Icons.payments,
                  label: 'Down Payment',
                  info: table.downPayment!,
                ),
                const SizedBox(height: 10.0),
                buildBottomSheetInformation(
                  icon: Icons.groups,
                  label: 'Capacity',
                  info: table.capacity!,
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: SBButton(
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: BlocBuilder<ReservationBloc, ReservationState>(
                        builder: (context, state) {
                          return SBButton(
                            onPressed: (state is ReservationLoading)
                                ? null
                                : () {
                                    BlocProvider.of<ReservationBloc>(context).add(
                                      CreateReservation(
                                        storeId: storeId,
                                        date: date,
                                        table: table,
                                      ),
                                    );
                                  },
                            child: (state is ReservationLoading)
                                ? const Center(
                                    child: SBLoading(color: Colors.white),
                                  )
                                : const Text(
                                    'Reserve',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheetInformation({
    required IconData icon,
    required String label,
    required String info,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  icon,
                  color: accentColor,
                ),
              ),
              const WidgetSpan(
                child: SizedBox(width: 5.0),
              ),
              TextSpan(text: label),
            ],
          ),
        ),
        Text(info),
      ],
    );
  }

  Widget buildButtonTab({
    required bool active,
    required int tabIndex,
    required String label,
  }) {
    return Expanded(
      child: TextButton(
        style: active
            ? TextButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: accentColor,
              )
            : TextButton.styleFrom(
                side: BorderSide(
                  color: accentColor,
                ),
                foregroundColor: accentColor,
              ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : accentColor,
            fontSize: 12.0,
          ),
        ),
        onPressed: () {
          BlocProvider.of<TableBloc>(context).add(
            TabChange(
              tabIndex: tabIndex,
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildStage({
    required int tabIndex,
    required double height,
    required double width,
  }) {
    return tabIndex == 0
        ? [
            Positioned(
              top: height * .12,
              right: width * .3,
              left: width * .35,
              child: Container(
                height: width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(width * 0.01),
                ),
                child: Center(
                  child: Text(
                    'STAGE',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            )
          ]
        : [
            Positioned(
              top: height * .2,
              left: width * .2,
              child: Container(
                width: width * 0.2,
                height: width * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'BAR',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            )
          ];
  }

  List<Widget> buildTableLabel({
    required int tabIndex,
    required double height,
    required double width,
  }) {
    return tabIndex == 0
        ? [
            Positioned(
              top: height * .08,
              right: width * .08,
              child: const Text('TOM FORD'),
            ),
            Positioned(
              top: height * .5,
              child: const Text('CELINE'),
            ),
            Positioned(
              top: height * .28,
              left: width * .02,
              child: Transform.rotate(
                angle: -math.pi / 3,
                child: const Text('CHANEL'),
              ),
            ),
            Positioned(
              top: height * .7,
              left: width * .02,
              child: Transform.rotate(
                angle: math.pi / 3,
                child: const Text('CHANEL'),
              ),
            ),
            Positioned(
              top: height * .28,
              right: width * .02,
              child: Transform.rotate(
                angle: math.pi / 3,
                child: const Text('CHANEL'),
              ),
            ),
            Positioned(
              top: height * .7,
              right: width * .02,
              child: Transform.rotate(
                angle: -math.pi / 3,
                child: const Text('CHANEL'),
              ),
            ),
          ]
        : [
            Positioned(
              top: height * .08,
              left: width * .2,
              child: const Text('BALENCIAGA (III)'),
            ),
            Positioned(
              top: height * .51,
              left: width * .0,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: const Text('YSL'),
              ),
            ),
            Positioned(
              top: height * .505,
              left: width * .22,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: const Text('PRADA'),
              ),
            ),
            Positioned(
              top: height * .505,
              right: width * .22,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: const Text('PRADA'),
              ),
            ),
            Positioned(
              top: height * .51,
              right: width * .0,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: const Text('YSL'),
              ),
            ),
            Positioned(
              top: height * .92,
              left: width * .05,
              child: const Text('BALENCIAGA (I)'),
            ),
            Positioned(
              top: height * .84,
              child: const Text('DIOR'),
            ),
            Positioned(
              top: height * .92,
              right: width * .05,
              child: const Text('BALENCIAGA (II)'),
            ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Text(
            widget.storeName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10.0),
          Text(
            widget.dateDisplay,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 2.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButtonTab(
                  active: widget.tabIndex == 0,
                  tabIndex: 0,
                  label: '1st Floor',
                ),
                const SizedBox(width: 10.0),
                buildButtonTab(
                  active: widget.tabIndex == 1,
                  tabIndex: 1,
                  label: '2nd Floor',
                ),
              ],
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              minScale: 0.2,
              maxScale: 3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ...buildStage(
                        tabIndex: widget.tabIndex,
                        height: height,
                        width: width,
                      ),
                      ...buildTableLabel(
                        tabIndex: widget.tabIndex,
                        height: height,
                        width: width,
                      ),
                      ...widget.tables.map(
                        (table) => Positioned(
                          top: table.top == null ? null : height * table.top!,
                          right: table.right == null ? null : width * table.right!,
                          bottom: table.bottom == null ? null : height * table.bottom!,
                          left: table.left == null ? null : width * table.left!,
                          child: GestureDetector(
                            onTap: table.isAvailable!
                                ? () {
                                    setState(() {
                                      _selectedTableNo = int.parse(table.id!);
                                      _selectedTable = table;
                                    });

                                    selectTable(
                                      storeId: widget.storeId,
                                      date: widget.date,
                                      table: _selectedTable!,
                                    );
                                  }
                                : null,
                            child: Container(
                              width: width * (widget.tabIndex == 0 ? 0.08 : 0.06),
                              height: width * (widget.tabIndex == 0 ? 0.08 : 0.06),
                              decoration: BoxDecoration(
                                color: !table.isAvailable!
                                    ? Colors.green
                                    : (_selectedTableNo == int.parse(table.id!))
                                        ? accentColor
                                        : Colors.grey,
                                borderRadius: BorderRadius.circular(
                                  width * 0.01,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  table.tableNo!.toLowerCase().replaceAll('table ', ''),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: ReservationLegend(),
          ),
        ],
      ),
    );
  }
}
