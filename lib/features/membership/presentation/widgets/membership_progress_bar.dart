import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../data/models/membership_type.dart';
import '../bloc/membership_bloc.dart';
import '../bloc/membership_state.dart';

class MembershipProgressBar extends StatefulWidget {
  const MembershipProgressBar({super.key});

  @override
  MembershipProgressBarState createState() => MembershipProgressBarState();
}

class MembershipProgressBarState extends State<MembershipProgressBar> {
  final List<MembershipTypeModel> membershipType = [
    const MembershipTypeModel(id: 1, label: 'Basic'),
    const MembershipTypeModel(id: 2, label: 'VIP'),
    const MembershipTypeModel(id: 3, label: 'Priority'),
  ];

  List<Widget> buildStepIndicator() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: membershipType.map((type) {
          final aligment = type.id == 1
              ? CrossAxisAlignment.start
              : type.id == 3
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.center;

          return Column(
            crossAxisAlignment: aligment,
            children: [
              const Icon(
                Icons.circle,
                color: Colors.grey,
                size: 24.0,
              ),
              const SizedBox(height: 2),
              Text(
                type.label!,
                style: TextStyle(color: accentColor),
              ),
            ],
          );
        }).toList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipBloc, MembershipState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: accentColor),
                    ),
                    height: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: LinearProgressIndicator(
                        value: 0,
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                        backgroundColor: backgroundColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 38.0,
                      child: Column(
                        children: buildStepIndicator(),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30.0),
              Text(state is MembershipDone
                  ? state.membership!.diffNextTier!
                  : ''),
            ],
          ),
        );
      },
    );
  }
}
