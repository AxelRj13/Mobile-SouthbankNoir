import 'package:flutter/material.dart';

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
      route: '',
    ),
    const MenuModel(
      id: 2,
      label: 'Outlet Info',
      image: 'assets/img/outlet.png',
      route: '',
    ),
    const MenuModel(
      id: 3,
      label: 'News & Promos',
      image: 'assets/img/promotion.png',
      route: '',
    ),
    const MenuModel(
      id: 4,
      label: 'Complaint',
      image: 'assets/img/complaint.png',
      route: '',
    ),
    const MenuModel(
      id: 5,
      label: 'Contact Us',
      image: 'assets/img/contact.png',
      route: '',
    ),
  ];

  Widget _buildMenuItem(String label, String image) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width / 8.0,
            ),
            const SizedBox(height: 5.0),
            Text(
              label,
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
              .map((menu) => _buildMenuItem(menu.label!, menu.image!))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _menus
              .where((menu) => menu.id! > 3)
              .map((menu) => _buildMenuItem(menu.label!, menu.image!))
              .toList(),
        ),
      ],
    );
  }
}
