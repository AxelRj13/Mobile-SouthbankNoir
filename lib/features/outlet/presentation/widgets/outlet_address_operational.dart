import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/dialog.dart';
import '../../data/models/operational_hours.dart';

class OutletAddressOperational extends StatelessWidget {
  final String? address;
  final String? androidDirection;
  final String? iosDirection;
  final List<OperationalHoursModel>? operationalHours;

  const OutletAddressOperational({
    super.key,
    this.address,
    this.androidDirection,
    this.iosDirection,
    this.operationalHours,
  });

  launchMapDirection(context) async {
    String url = '';

    if (Platform.isAndroid) {
      url = androidDirection!;
    } else if (Platform.isIOS) {
      url = iosDirection!;
    }

    try {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch direction';
      }
    } catch (e) {
      basicDialog(context, 'Information', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
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
                icon: const FaIcon(
                  FontAwesomeIcons.mapLocationDot,
                  color: Colors.white,
                ),
                label: const Text(
                  'Direction',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => launchMapDirection(context),
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
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              for (final operational in operationalHours!)
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
          ),
          const SizedBox(height: 20.0),
          SBButton(
            child: const Text(
              'Reservation',
              style: TextStyle(fontSize: 16.0),
            ),
            onPressed: () {
              router.goNamed('reservation');
            },
          )
        ],
      ),
    );
  }
}
