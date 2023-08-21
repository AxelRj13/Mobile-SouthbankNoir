import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/router.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth/remote/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth/remote/auth_event.dart';
import 'features/auth/presentation/bloc/auth/remote/auth_state.dart';
// import 'package:southbank/features/news/presentation/bloc/news/remote/remote_news_bloc.dart';
// import 'package:southbank/features/news/presentation/bloc/news/remote/remote_news_event.dart';
// import 'package:southbank/features/news/presentation/news_screen.dart';
import 'injection_container.dart';
// import 'package:southbank/features/banner/presentation/pages/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => getIt.get<AuthBloc>()..add(CheckSignInStatus()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserSignedIn) {
            router.goNamed('main');
          } else if (state is UserSignedOut) {
            router.goNamed('auth');
          } else if (state is PrepareUser) {
            router.goNamed('splash');
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          theme: theme(),
        ),
      ),
    );
  }
}
