import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/theme/app_theme.dart';

class OutletInformation extends StatelessWidget {
  final String? outletName;
  final String? openHour;
  final String? phone;
  final bool? isOpen;

  const OutletInformation({
    super.key,
    this.outletName,
    this.openHour,
    this.phone,
    this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
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
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.clock),
                      const SizedBox(width: 8.0),
                      Text(openHour!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isOpen! ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(isOpen! ? 'OPEN' : 'CLOSE'),
          ),
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: phone != null
                ? () async {
                    final uri = Uri.parse(phone!);
                    if (await canLaunchUrl(uri)) {
                      launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  }
                : null,
            icon: const FaIcon(FontAwesomeIcons.whatsapp),
          ),
        ],
      ),
    );
  }
}
