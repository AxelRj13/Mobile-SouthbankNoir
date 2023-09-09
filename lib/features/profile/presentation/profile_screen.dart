import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/button.dart';
import '../../../core/components/loading.dart';
import '../../../injection_container.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../auth/presentation/bloc/auth_event.dart';
import 'bloc/profile/profile_bloc.dart';
import 'bloc/profile/profile_event.dart';
import 'bloc/profile/profile_state.dart';
import 'widgets/profile_bottom_menu.dart';
import 'widgets/profile_card.dart';
import 'widgets/profile_menu.dart';
import 'widgets/progress_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (BuildContext context) =>
          getIt.get<ProfileBloc>()..add(CheckProfile()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDone) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ProfileCard(user: state.user!),
                  const ProgressBar(),
                  const SizedBox(height: 30.0),
                  // const Text('Next Level'),
                  const SizedBox(height: 30.0),
                  const ProfileMenu(),
                  const SizedBox(height: 15.0),
                  const ProfileBottomMenu(),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SBButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          Logout(),
                        );
                      },
                      child: const Text('Log out'),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: SBLoading());
        },
      ),
    );
  }
}
