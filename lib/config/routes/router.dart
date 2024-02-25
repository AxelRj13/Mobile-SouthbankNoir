import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../core/screen/main_screen.dart';
import '../../core/screen/news_promo_screen.dart';
import '../../core/screen/privacy_policy_screen.dart';
import '../../core/screen/splash_screen.dart';
import '../../core/screen/terms_condition_screen.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/complaint/presentation/complaint_screen.dart';
import '../../features/coupon/presentation/coupon_detail_screen.dart';
import '../../features/coupon/presentation/coupon_screen.dart';
import '../../features/events/presentation/event_detail_screen.dart';
import '../../features/news/presentation/news_detail_screen.dart';
import '../../features/outlet/presentation/outlet_screen.dart';
import '../../features/payment/data/models/payment.dart';
import '../../features/payment/presentation/payment_confirm_screen.dart';
import '../../features/payment/presentation/payment_screen.dart';
import '../../features/profile/presentation/profile_edit_screen.dart';
import '../../features/promo/presentation/promo_detail_screen.dart';
import '../../features/reservation/data/models/reservation_confirm.dart';
import '../../features/reservation/presentation/my_reservation_screen.dart';
import '../../features/reservation/presentation/reservation_confirm_screen.dart';
import '../../features/reservation/presentation/reservation_detail_screen.dart';
import '../../features/reservation/presentation/reservation_screen.dart';

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
              path: 'news/detail/:newsId',
              name: 'newsDetail',
              builder: (context, state) => NewsDetailScreen(
                id: state.pathParameters['newsId']!,
              ),
            ),
            GoRoute(
              path: 'promo/detail/:promoId',
              name: 'promoDetail',
              builder: (context, state) => PromoDetailScreen(
                id: state.pathParameters['promoId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'complaint',
          name: 'complaint',
          builder: (context, state) => const ComplaintScreen(),
        ),
        GoRoute(
          path: 'profile/edit',
          name: 'profileEdit',
          builder: (context, state) => const ProfileEditScreen(),
        ),
        GoRoute(
          path: 'coupons/:type',
          name: 'coupons',
          builder: (context, state) => CouponScreen(
            type: state.pathParameters['type']!,
          ),
          routes: [
            GoRoute(
              path: 'detail/:couponId',
              name: 'couponDetail',
              builder: (context, state) => CouponDetailScreen(
                type: state.pathParameters['type']!,
                id: state.pathParameters['couponId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'reservation',
          name: 'reservation',
          builder: (context, state) {
            final rsvpDate = state.uri.queryParameters['rsvpDate'];
            return ReservationScreen(rsvpDate: rsvpDate);
          },
          routes: [
            GoRoute(
              path: 'confirmation',
              name: 'confirmation',
              builder: (context, state) {
                ReservationConfirmModel reservationConfirm = state.extra as ReservationConfirmModel;
                return ReservationConfirmScreen(
                  reservationConfirm: reservationConfirm,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'my-booking',
          name: 'myBooking',
          builder: (context, state) {
            return MyReservationScreen(
              key: UniqueKey(),
            );
          },
          routes: [
            GoRoute(
              path: 'detail/:bookingId/:bookingNo',
              name: 'bookingDetail',
              builder: (context, state) => ReservationDetailScreen(
                bookingId: state.pathParameters['bookingId']!,
                bookingNo: state.pathParameters['bookingNo']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'payment/:bookingId',
          name: 'payment',
          builder: (context, state) => PaymentConfirmScreen(
            bookingId: state.pathParameters['bookingId']!,
            redirectUrl: state.uri.queryParameters['redirectUrl']!,
          ),
          routes: [
            GoRoute(
              path: 'payment-confirmation',
              name: 'paymentConfirm',
              builder: (context, state) {
                PaymentModel payment = state.extra as PaymentModel;
                return PaymentScreen(payment: payment);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'event/detail/:eventId',
          name: 'eventDetail',
          builder: (context, state) => EventDetailScreen(
            id: state.pathParameters['eventId']!,
          ),
        ),
        GoRoute(
          path: 'privacy-policy',
          name: 'privacyPolicy',
          builder: (context, state) {
            final urlContent = state.uri.queryParameters['urlContent'];
            return PrivacyPolicyScreen(urlContent: urlContent!);
          },
        ),
        GoRoute(
          path: 'terms-condition',
          name: 'tnc',
          builder: (context, state) {
            final urlContent = state.uri.queryParameters['urlContent'];
            return TermsConditionScreen(urlContent: urlContent!);
          },
        ),
      ],
    ),
  ],
  initialLocation: '/splash',
  debugLogDiagnostics: true,
);
