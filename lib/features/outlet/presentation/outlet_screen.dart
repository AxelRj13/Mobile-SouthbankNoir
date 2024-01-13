import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/loading.dart';
import '../../../injection_container.dart';
import 'bloc/outlet_bloc.dart';
import 'bloc/outlet_event.dart';
import 'bloc/outlet_state.dart';
import 'widgets/image_cover.dart';
import 'widgets/outlet_address_operational.dart';
import 'widgets/outlet_information.dart';

class OutletScreen extends StatefulWidget {
  const OutletScreen({super.key});

  @override
  State<OutletScreen> createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlet'),
      ),
      body: BlocProvider<OutletBloc>(
        create: (BuildContext context) => getIt.get<OutletBloc>()..add(const GetOutlet()),
        child: BlocBuilder<OutletBloc, OutletState>(
          builder: (context, state) {
            if (state is OutletDone) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ImageCover(image: state.outlet!.image),
                    OutletInformation(
                      outletName: state.outlet!.name,
                      openHour: state.todayOperationalHour!.hour,
                      phone: state.outlet!.phone,
                      isOpen: state.todayOperationalHour!.isOpen,
                    ),
                    OutletAddressOperational(
                      address: state.outlet!.address,
                      androidDirection: state.outlet!.androidDirection,
                      iosDirection: state.outlet!.iosDirection,
                      operationalHours: state.operationalHours!,
                    )
                  ],
                ),
              );
            }

            if (state is OutletError) {
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
    );
  }
}
