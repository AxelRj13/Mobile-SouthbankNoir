import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/reservation/reservation_bloc.dart';
import 'bloc/reservation/reservation_event.dart';
import 'widgets/reservation_detail_widget.dart';

class ReservationDetailScreen extends StatefulWidget {
  final String bookingId;
  final String bookingNo;

  const ReservationDetailScreen({
    super.key,
    required this.bookingId,
    required this.bookingNo,
  });

  @override
  State<ReservationDetailScreen> createState() => _ReservationDetailScreenState();
}

class _ReservationDetailScreenState extends State<ReservationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookingNo),
      ),
      body: BlocProvider<ReservationBloc>(
        create: (context) => getIt.get<ReservationBloc>()
          ..add(
            GetReservationDetail(
              bookingId: widget.bookingId,
            ),
          ),
        child: const ReservationDetailWidget(),
      ),
    );
  }
}
