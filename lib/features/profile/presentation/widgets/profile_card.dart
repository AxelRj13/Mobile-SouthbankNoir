import 'package:flutter/material.dart';

import '../../../auth/data/models/user.dart';
import '../../../membership/presentation/widgets/membership_profile_widget.dart';

class ProfileCard extends StatelessWidget {
  final UserModel user;

  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            image: DecorationImage(
              image: AssetImage("assets/img/profile-backdrop.png"),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: user.photo != '-'
                          ? NetworkImage(user.photo!)
                          : const AssetImage('assets/img/profile-default.png')
                              as ImageProvider,
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${user.firstName!} ${user.lastName!}'),
                        Text(user.phone!),
                        Text(user.email!),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              const MembershipProfileWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
