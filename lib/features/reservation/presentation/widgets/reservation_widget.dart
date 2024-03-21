import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/dialog.dart';
import '../../../../injection_container.dart';
import '../../data/models/reservation_confirm.dart';
import '../../domain/entities/table_detail.dart';
import '../bloc/table/table_bloc.dart';
import '../bloc/table/table_event.dart';
import '../reservation_confirm_screen.dart';
import 'reservation_legend.dart';

class ReservationWidget extends StatefulWidget {
  final int tabIndex;
  final DateTime selectedDate;
  final int storeId;
  final String storeName;
  final String storeImage;
  final String date;
  final String dateDisplay;
  final String event;
  final List<TableDetailEntity> tables;

  const ReservationWidget({
    super.key,
    required this.tabIndex,
    required this.selectedDate,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.date,
    required this.dateDisplay,
    required this.event,
    required this.tables,
  });

  @override
  State<ReservationWidget> createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  final List<TableDetailEntity> _selectedTables = [];

  void selectTable({
    required ThemeData theme,
    required TableDetailEntity table,
  }) {
    final isSelected = _selectedTables.where((selectedTable) => selectedTable.id == table.id).isNotEmpty;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              table.tableName!.toUpperCase(),
              style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              table.tableNo!,
              style: theme.textTheme.titleLarge!,
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
                  child: SBButton(
                    color: isSelected ? Colors.red : accentColor,
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTables.removeWhere((selectedTable) => selectedTable.id == table.id);
                        } else {
                          _selectedTables.add(table);
                        }
                      });

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      isSelected ? 'Remove' : 'Reserve',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            )
          ],
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    // Karena width offset padding kiri-kanan harusnya sama dengan height dari gambar
    // jadi untuk height menggunakan variabel width
    final width = size.width;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Text(
            widget.storeName,
            style: theme.textTheme.titleLarge!.copyWith(
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
          const SizedBox(height: 5.0),
          Text(
            'Event : ${widget.event}',
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
              maxScale: 2,
              child: Stack(
                children: [
                  Image.asset(widget.tabIndex == 1 ? 'assets/img/floor-2.png' : 'assets/img/floor-1.png'),
                  ...widget.tables.map(
                    (table) {
                      return Positioned(
                        top: table.top == null ? null : (width - 20.0) * table.top!,
                        right: table.right == null ? null : width * table.right!,
                        bottom: table.bottom == null ? null : (width - 20.0) * table.bottom!,
                        left: table.left == null ? null : width * table.left!,
                        child: GestureDetector(
                          onTap: table.isAvailable!
                              ? () {
                                  selectTable(
                                    theme: theme,
                                    table: table,
                                  );
                                }
                              : null,
                          child: Container(
                            width: width * (widget.tabIndex == 0 ? 0.045 : 0.035),
                            height: width * (widget.tabIndex == 0 ? 0.045 : 0.035),
                            decoration: BoxDecoration(
                                color: !table.isAvailable!
                                    ? Colors.green
                                    : _selectedTables.where((selectedTable) => selectedTable.id == table.id).isNotEmpty
                                        ? accentColor
                                        : Colors.grey,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                table.tableNo!.toLowerCase().replaceAll('table ', ''),
                                style: TextStyle(fontSize: width < 450 ? 9 : 11),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: ReservationLegend(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: SBButton(
              child: const Text('Make Reservation'),
              onPressed: () async {
                if (_selectedTables.isEmpty) {
                  await basicDialog(context, 'Information', 'Please select table first');

                  return;
                }

                final prefs = getIt.get<SharedPreferences>();

                final firstName = prefs.get('firstName') ?? '';
                final lastName = prefs.get('lastName') ?? '';
                final phone = prefs.get('phone') ?? '';

                final reservationConfirm = ReservationConfirmModel(
                  storeId: widget.storeId,
                  storeName: widget.storeName,
                  storeImage: widget.storeImage,
                  date: widget.date,
                  dateDisplay: widget.dateDisplay,
                  event: widget.event,
                  personName: '$firstName $lastName',
                  personPhone: phone.toString(),
                  table: _selectedTables,
                );

                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => ReservationConfirmScreen(reservationConfirm: reservationConfirm),
                  ),
                )
                    .then(
                  (value) {
                    if (value != null && value) {
                      context.read<TableBloc>().add(
                            GetTables(
                              date: DateFormat('yyyy-MM-dd').format(widget.selectedDate),
                            ),
                          );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
