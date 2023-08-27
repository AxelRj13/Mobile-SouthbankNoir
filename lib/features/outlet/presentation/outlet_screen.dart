import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:southbank/config/theme/app_theme.dart';
import 'package:southbank/core/components/button.dart';
import 'package:southbank/core/components/dialog.dart';
import 'package:southbank/core/components/loading.dart';
import 'package:southbank/features/outlet/presentation/bloc/outlet_bloc.dart';
import 'package:southbank/features/outlet/presentation/bloc/outlet_event.dart';
import 'package:southbank/features/outlet/presentation/bloc/outlet_state.dart';
import 'package:southbank/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/operational_hours.dart';

class OutletScreen extends StatefulWidget {
  const OutletScreen({super.key});

  @override
  State<OutletScreen> createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  Widget buildImageCover(String? image) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image != null
              ? NetworkImage(image)
              : const AssetImage('assets/img/logo.png') as ImageProvider,
        ),
      ),
    );
  }

  Widget buildOpenCloseSign(bool isOpen) {
    return Container(
      decoration: BoxDecoration(
        color: isOpen ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Text(isOpen ? 'OPEN' : 'CLOSE'),
    );
  }

  Widget buildOutletInformation(
    String? outletName,
    String? openHour,
    String? phone,
    bool? isOpen,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(color: appbarColor),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 4.0,
                  ),
                  child: Text(
                    outletName ?? '-',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 8.0),
                      Text(openHour!),
                    ],
                  ),
                )
              ],
            ),
          ),
          buildOpenCloseSign(isOpen!),
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: phone != null
                ? () async {
                    final uri = Uri.parse(phone);
                    if (await canLaunchUrl(uri)) {
                      launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  }
                : null,
            icon: const Icon(Icons.phone),
          ),
        ],
      ),
    );
  }

  Widget buildOperationalHours(List<OperationalHoursModel> operationalHours) {
    return Column(
      children: [
        for (final operational in operationalHours)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(operational.day!),
                Text(operational.hour!),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildOutletAddressAndOperational(
    String? address,
    String? direction,
    List<OperationalHoursModel> operationalHours,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child: Text(
                        'Address',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(address!),
                  ],
                ),
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(accentColor),
                ),
                icon: const Icon(
                  Icons.assistant_direction,
                  color: Colors.white,
                ),
                label: const Text(
                  'Direction',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: direction != null
                    ? () async {
                        final uri = Uri.parse(direction);
                        if (Platform.isAndroid && await canLaunchUrl(uri)) {
                          launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    : null,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Opening Hours',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          buildOperationalHours(operationalHours),
          const SizedBox(height: 20.0),
          SBButton(
            child: const Text(
              'Reservation',
              style: TextStyle(fontSize: 16.0),
            ),
            onPressed: () {
              comingsoonDialog(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlet'),
      ),
      body: BlocProvider<OutletBloc>(
        create: (BuildContext context) =>
            getIt.get<OutletBloc>()..add(const GetOutlet()),
        child: BlocBuilder<OutletBloc, OutletState>(
          builder: (context, state) {
            if (state is OutletDone) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    buildImageCover(state.outlet!.image),
                    buildOutletInformation(
                      state.outlet!.name,
                      state.todayOperationalHour!.hour,
                      state.outlet!.phone,
                      state.todayOperationalHour!.isOpen,
                    ),
                    buildOutletAddressAndOperational(state.outlet!.address,
                        state.outlet!.direction, state.operationalHours!),
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
