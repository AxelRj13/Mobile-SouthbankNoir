import 'package:go_router/go_router.dart';

import '../../core/screen/splash_screen.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/outlet/presentation/outlet_screen.dart';
import '../../main_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: '/',
      name: 'main',
      builder: (context, state) {
        return const MainScreen();
      },
      routes: [
        GoRoute(
          path: 'outlet',
          name: 'outlet',
          builder: (context, state) {
            return const OutletScreen();
          },
        ),
      ],
    ),
  ],
  initialLocation: '/splash',
  debugLogDiagnostics: true,
);
