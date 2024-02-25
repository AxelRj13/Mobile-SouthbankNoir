import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../bloc/membership_bloc.dart';
import '../bloc/membership_state.dart';

class MembershipProfileWidget extends StatefulWidget {
  const MembershipProfileWidget({super.key});

  @override
  State<MembershipProfileWidget> createState() => _MembershipProfileWidgetState();
}

class _MembershipProfileWidgetState extends State<MembershipProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipBloc, MembershipState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Membership Tier'),
                    const SizedBox(height: 15.0),
                    Text(
                      state is MembershipDone ? state.membership!.name!.toUpperCase() : '',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Your Points'),
                    const SizedBox(height: 15.0),
                    Text(
                      '${state is MembershipDone ? state.membership!.points ?? 0 : 0}',
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
        );
      },
    );
  }
}
