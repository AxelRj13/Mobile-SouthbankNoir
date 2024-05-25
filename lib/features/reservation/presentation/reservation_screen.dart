import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../config/theme/app_theme.dart';
import '../../../core/components/dialog.dart';
import '../../../core/components/loading.dart';
import '../../../injection_container.dart';
import 'bloc/table/table_bloc.dart';
import 'bloc/table/table_event.dart';
import 'bloc/table/table_state.dart';
import 'widgets/reservation_widget.dart';

class ReservationScreen extends StatefulWidget {
  final String? rsvpDate;

  const ReservationScreen({
    super.key,
    this.rsvpDate,
  });

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime selectedDate = DateTime.now();

  Future<DateTime?> selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: accentColor,
              onPrimary: Colors.white,
              surface: backgroundColor,
            ),
            dialogBackgroundColor: backgroundColor,
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = widget.rsvpDate != null ? DateTime.parse(widget.rsvpDate!) : selectedDate;

    return BlocProvider<TableBloc>(
      create: (context) => getIt.get<TableBloc>()
        ..add(
          GetTables(
            date: DateFormat('yyyy-MM-dd').format(selectedDate),
          ),
        ),
      child: BlocListener<TableBloc, TableState>(
        listener: (context, state) async {
          if (state is TableInitial) {
            if (state.isBookingClosed!) {
              await basicDialog(context, 'Reservation Closed', state.bookingClosedWording!);
              if (mounted) Navigator.of(context).pop();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Reservation'),
            actions: [
              BlocBuilder<TableBloc, TableState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      BlocProvider.of<TableBloc>(context).add(
                        GetTables(
                          date: DateFormat('yyyy-MM-dd').format(selectedDate),
                        ),
                      );
                    },
                  );
                },
              ),
              BlocBuilder<TableBloc, TableState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () async {
                      final newSelectedDate = await selectDate(context);

                      if (selectedDate != newSelectedDate) {
                        if (mounted) {
                          BlocProvider.of<TableBloc>(context).add(
                            GetTables(
                              date: DateFormat('yyyy-MM-dd').format(newSelectedDate!),
                            ),
                          );

                          selectedDate = newSelectedDate;
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<TableBloc, TableState>(
            builder: (context, state) {
              if (state is TableInitial) {
                return ReservationWidget(
                  tabIndex: state.tabIndex!,
                  selectedDate: selectedDate,
                  storeId: state.storeId!,
                  storeName: state.storeName!,
                  storeImage: state.storeImage!,
                  date: state.date!,
                  dateDisplay: state.dateDisplay!,
                  event: state.event!,
                  tables: state.tables!,
                );
              }

              if (state is TableError) {
                return const Center(
                  child: Icon(Icons.refresh),
                );
              }

              return const Center(
                child: SBLoading(),
              );
            },
          ),
        ),
      ),
    );
  }
}
