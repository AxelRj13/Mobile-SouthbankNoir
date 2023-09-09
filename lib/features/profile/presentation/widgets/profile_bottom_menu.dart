import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/dialog.dart';
import '../../data/models/menu.dart';

class ProfileBottomMenu extends StatefulWidget {
  const ProfileBottomMenu({super.key});

  @override
  State<ProfileBottomMenu> createState() => _ProfileBottomMenuState();
}

class _ProfileBottomMenuState extends State<ProfileBottomMenu> {
  List<ProfileMenuModel> menu = [
    const ProfileMenuModel(
      id: 1,
      label: 'Rate Us',
      icon: Icons.star,
    ),
    const ProfileMenuModel(
      id: 2,
      label: 'Share',
      icon: Icons.share,
    ),
    const ProfileMenuModel(
      id: 3,
      label: 'Contact Us',
      icon: Icons.email,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: menu.map((menu) {
          final size = MediaQuery.of(context).size.width * 0.15;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: size,
                  height: size,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      shape: const CircleBorder(),
                    ),
                    child: Center(
                      child: Icon(
                        menu.icon,
                        size: size * 0.5,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (menu.id == 3) {
                        final uri = Uri.parse(
                            'https://api.whatsapp.com/send/?phone=62818283939&text&type=phone_number&app_absent=0');
                        if (await canLaunchUrl(uri)) {
                          launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      } else {
                        comingsoonDialog(context);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(menu.label!),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
