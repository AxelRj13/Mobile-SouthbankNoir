import 'package:go_router/go_router.dart';

import '../../core/screen/splash_screen.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/complaint/presentation/complaint_screen.dart';
import '../../features/news/presentation/news_detail_screen.dart';
import '../../features/news/presentation/news_promo_screen.dart';
import '../../features/outlet/presentation/outlet_screen.dart';
import '../../main_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'main',
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(
          path: 'outlet',
          name: 'outlet',
          builder: (context, state) => const OutletScreen(),
        ),
        GoRoute(
            path: 'news',
            name: 'news',
            builder: (context, state) => const NewsPromoScreen(),
            routes: [
              GoRoute(
                path: 'detail/:newsId',
                name: 'newsDetail',
                builder: (context, state) {
                  return NewsDetailScreen(id: state.pathParameters['newsId']!);
                },
              ),
            ]),
        GoRoute(
          path: 'complaint',
          name: 'complaint',
          builder: (context, state) => const ComplaintScreen(),
        ),
      ],
    ),
  ],
  initialLocation: '/splash',
  debugLogDiagnostics: true,
);
