import 'package:flutter/material.dart';
import 'package:southbank/config/routes/router.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/dialog.dart';
import '../../../../core/constants/constants.dart';
import '../../data/models/menu.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  List<ProfileMenuModel> menu = [
    const ProfileMenuModel(
      id: 1,
      label: 'Edit Profile',
      icon: Icons.account_circle_outlined,
      route: ProfileMenuRouteModel(route: 'profileEdit'),
    ),
    const ProfileMenuModel(
      id: 2,
      label: 'My Bookings',
      icon: Icons.book_online,
      route: ProfileMenuRouteModel(route: 'comingsoon'),
    ),
    const ProfileMenuModel(
      id: 3,
      label: 'My Coupons',
      icon: Icons.sell,
      route: ProfileMenuRouteModel(
          route: 'coupons', parameter: {'type': myCoupon}),
    ),
    const ProfileMenuModel(
      id: 4,
      label: 'Terms & Conditions',
      icon: Icons.checklist,
      route: ProfileMenuRouteModel(route: 'comingsoon'),
    ),
    const ProfileMenuModel(
      id: 5,
      label: 'App Version',
      icon: Icons.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: appbarColor,
        ),
        child: Column(
          children: menu.map((menu) {
            final trailing = menu.id == 5
                ? const Text('1.1.0')
                : const Icon(Icons.chevron_right);

            return ListTile(
              leading: Icon(menu.icon),
              title: Text(menu.label!),
              trailing: trailing,
              onTap: () {
                if (menu.route != null) {
                  if (menu.id == 1) {
                    router.goNamed(menu.route!.route!);
                  } else if (menu.id == 3) {
                    router.goNamed(
                      menu.route!.route!,
                      pathParameters: menu.route!.parameter!,
                    );
                  } else {
                    comingsoonDialog(context);
                  }
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
