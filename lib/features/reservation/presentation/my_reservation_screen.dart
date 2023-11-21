import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/reservation/reservation_bloc.dart';
import 'bloc/reservation/reservation_event.dart';
import 'widgets/my_reservation_widget.dart';

class MyReservationScreen extends StatefulWidget {
  const MyReservationScreen({super.key});

  @override
  State<MyReservationScreen> createState() => _MyReservationScreenState();
}

class _MyReservationScreenState extends State<MyReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReservationBloc>(
      create: (context) => getIt.get<ReservationBloc>()
        ..add(
          const GetReservations(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
        ),
        body: const MyReservationWidget(),
      ),
    );
  }
}
