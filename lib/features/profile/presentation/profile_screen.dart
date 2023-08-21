import 'package:flutter/material.dart';
import 'package:southbank/config/theme/app_theme.dart';
import 'package:southbank/features/profile/presentation/widgets/progress_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 23,
                              backgroundImage:
                                  AssetImage('assets/img/profile-default.png'),
                            ),
                          ),
                          SizedBox(width: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Member Name'),
                              Text('08123456789'),
                              Text('email@gmail.com'),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Membership Tier'),
                                const SizedBox(height: 15.0),
                                Text(
                                  'BASIC',
                                  style: TextStyle(
                                    color: accentColor,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                              color: Colors.white, width: 2, thickness: 5.0),
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Your Points'),
                                const SizedBox(height: 15.0),
                                Text(
                                  '1200',
                                  style: TextStyle(
                                    color: accentColor,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const ProgressBar(),
        ],
      ),
    );
  }
}
