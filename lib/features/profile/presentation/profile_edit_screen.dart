import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/picture/picture_bloc.dart';
import 'bloc/profile_bloc.dart';
import 'widgets/profile_edit_form.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ProfileBloc>(
                create: (context) => getIt.get<ProfileBloc>(),
              ),
              BlocProvider<ProfilePictureBloc>(
                create: (context) => getIt.get<ProfilePictureBloc>(),
              )
            ],
            child: const ProfileEditForm(),
          ),
        ),
      ),
    );
  }
}
