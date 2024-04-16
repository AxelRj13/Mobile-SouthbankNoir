import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../membership/presentation/bloc/membership_bloc.dart';
import '../../../membership/presentation/bloc/membership_state.dart';
import '../../data/models/menu.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../profile_edit_screen.dart';

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
      route: ProfileMenuRouteModel(route: 'myBooking'),
    ),
    const ProfileMenuModel(
      id: 3,
      label: 'My Coupons',
      icon: Icons.sell,
      route: ProfileMenuRouteModel(
        route: 'coupons',
        parameter: {
          'type': myCoupon,
        },
      ),
    ),
    const ProfileMenuModel(
      id: 4,
      label: 'Terms & Conditions',
      icon: Icons.checklist,
      route: ProfileMenuRouteModel(route: 'tnc'),
    ),
    const ProfileMenuModel(
      id: 5,
      label: 'Privacy & Policy',
      icon: Icons.shield,
      route: ProfileMenuRouteModel(route: 'privacyPolicy'),
    ),
    const ProfileMenuModel(
      id: 6,
      label: 'App Version',
      icon: Icons.info,
    ),
  ];

  Widget buildMenuTile({
    required ProfileMenuModel menu,
    MembershipState? state,
  }) {
    String urlContent = 'https://southbanknoir.com/';
    Widget trailing = const Icon(Icons.chevron_right);

    if (menu.id == 6) {
      if (state is MembershipDone) {
        trailing = Text(state.membership!.appVersion!);
      } else {
        trailing = const Text('-');
      }
    }

    if (menu.id == 4) {
      if (state is MembershipDone) {
        urlContent = state.membership!.tncUrl!;
        urlContent = state.membership!.tncUrl!;
      }
    }

    if (menu.id == 5) {
      if (state is MembershipDone) {
        urlContent = state.membership!.privacyPolicyUrl!;
      }
    }

    return ListTile(
      leading: Icon(menu.icon),
      title: Text(menu.label!),
      trailing: trailing,
      onTap: () {
        if (menu.route != null) {
          if (menu.id == 1) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const ProfileEditScreen(),
              ),
            )
                .then(
              (value) {
                context.read<ProfileBloc>().add(CheckProfile());
              },
            );
          } else if (menu.id == 4 || menu.id == 5) {
            router.goNamed(
              menu.route!.route!,
              queryParameters: {
                'urlContent': urlContent,
              },
            );
          } else {
            router.goNamed(
              menu.route!.route!,
              pathParameters: menu.route!.parameter ?? {},
            );
          }
        }
      },
    );
  }

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
            if (menu.id! > 3) {
              return BlocBuilder<MembershipBloc, MembershipState>(
                builder: (_, state) {
                  return buildMenuTile(menu: menu, state: state);
                },
              );
            }

            return buildMenuTile(menu: menu);
          }).toList(),
        ),
      ),
    );
  }
}
