import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading.dart';
import '../../data/data_sources/google_sign_in_api_service.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return OutlinedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                const Size.fromHeight(50.0),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: Colors.white, width: 1.0),
              ),
            ),
            onPressed: state is AuthGoogleLoading
                ? null
                : () async {
                    try {
                      final googleAccount = await GoogleSignInApi.login();

                      if (googleAccount != null) {
                        if (mounted) {
                          final authBloc = BlocProvider.of<AuthBloc>(context);

                          authBloc.add(
                            LoginGoogle(
                              id: googleAccount.id,
                              email: googleAccount.email,
                              name: googleAccount.displayName,
                            ),
                          );
                        }

                        await GoogleSignInApi.logout();
                      } else {
                        print('User not found');
                      }
                    } catch (e) {
                      print("ERROR: $e");
                    }
                  },
            child: state is AuthGoogleLoading
                ? const SBLoading()
                : const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/img/google.png'),
                          height: 25.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
