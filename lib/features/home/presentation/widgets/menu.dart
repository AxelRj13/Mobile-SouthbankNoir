import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/routes/router.dart';
import '../../../../core/components/dialog.dart';
import '../../data/models/menu.dart';
import '../../domain/entities/menu.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<MenuEntity> _menus = [
    const MenuModel(
      id: 1,
      label: 'Reservation',
      image: 'assets/img/reservation.png',
    ),
    const MenuModel(
      id: 2,
      label: 'Outlet Info',
      image: 'assets/img/outlet.png',
      route: 'outlet',
    ),
    const MenuModel(
      id: 3,
      label: 'News & Promos',
      image: 'assets/img/promotion.png',
    ),
    const MenuModel(
      id: 4,
      label: 'Complaint',
      image: 'assets/img/complaint.png',
      route: 'complaint',
    ),
    const MenuModel(
      id: 5,
      label: 'Contact Us',
      image: 'assets/img/contact.png',
    ),
  ];

  Widget _buildMenuItem(MenuEntity menu) {
    return InkWell(
      onTap: () async {
        if (menu.route != null) {
          router.goNamed(menu.route!);
        } else if (menu.id == 5) {
          final uri = Uri.parse(
              'https://api.whatsapp.com/send/?phone=62818283939&text&type=phone_number&app_absent=0');
          if (await canLaunchUrl(uri)) {
            launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } else {
          comingsoonDialog(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            Image.asset(
              menu.image!,
              width: MediaQuery.of(context).size.width / 8.0,
            ),
            const SizedBox(height: 5.0),
            Text(
              menu.label!,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _menus
              .where((menu) => menu.id! < 4)
              .map((menu) => _buildMenuItem(menu))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _menus
              .where((menu) => menu.id! > 3)
              .map((menu) => _buildMenuItem(menu))
              .toList(),
        ),
      ],
    );
  }
}
