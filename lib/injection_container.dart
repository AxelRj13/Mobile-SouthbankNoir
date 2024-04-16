import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_client.dart';
import 'features/auth/data/data_sources/auth_api_service.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/check_email.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/complaint/data/data_sources/remote/complaint_api_service.dart';
import 'features/complaint/data/repository/complaint_repository_impl.dart';
import 'features/complaint/domain/repository/complaint_repository.dart';
import 'features/complaint/domain/usecases/get_complaint_types.dart';
import 'features/complaint/domain/usecases/send_complaint.dart';
import 'features/complaint/presentation/bloc/complaint/complaint_bloc.dart';
import 'features/complaint/presentation/bloc/types/complaint_type_bloc.dart';
import 'features/coupon/data/data_sources/coupon_api_service.dart';
import 'features/coupon/data/repository/coupon_repository_impl.dart';
import 'features/coupon/domain/repository/coupon_repository.dart';
import 'features/coupon/domain/usecases/buy_coupon.dart';
import 'features/coupon/domain/usecases/get_coupon.dart';
import 'features/coupon/domain/usecases/get_coupons.dart';
import 'features/coupon/domain/usecases/get_my_coupon.dart';
import 'features/coupon/presentation/bloc/coupon/coupon_bloc.dart';
import 'features/coupon/presentation/bloc/coupon_purchased/coupon_purchased_bloc.dart';
import 'features/events/data/data_sources/remote/event_api_service.dart';
import 'features/events/data/repository/event_repository_impl.dart';
import 'features/events/domain/repository/event_repository.dart';
import 'features/events/domain/usecases/get_event.dart';
import 'features/events/domain/usecases/get_events.dart';
import 'features/events/domain/usecases/get_today_event.dart';
import 'features/events/presentation/bloc/event_bloc.dart';
import 'features/home/data/data_sources/remote/popup_api_service.dart';
import 'features/home/data/repository/popup_repository_impl.dart';
import 'features/home/domain/repository/popup_repository.dart';
import 'features/home/domain/usecases/get_popup.dart';
import 'features/home/presentation/bloc/popup_bloc.dart';
import 'features/membership/data/data_sources/membership_api_service.dart';
import 'features/membership/data/repository/membership_repository_impl.dart';
import 'features/membership/domain/repository/membership_repository.dart';
import 'features/membership/domain/usecases/get_membership.dart';
import 'features/membership/presentation/bloc/membership_bloc.dart';
import 'features/news/data/data_sources/news_api_service.dart';
import 'features/news/data/repository/news_repository_impl.dart';
import 'features/news/domain/repository/news_repository.dart';
import 'features/news/domain/usecases/get_news.dart';
import 'features/news/domain/usecases/get_news_list.dart';
import 'features/news/presentation/bloc/news_bloc.dart';
import 'features/outlet/data/data_sources/outlet_api_service.dart';
import 'features/outlet/data/repository/outlet_repository_impl.dart';
import 'features/outlet/domain/repository/outlet_repository.dart';
import 'features/outlet/domain/usecases/get_outlet_details.dart';
import 'features/outlet/presentation/bloc/outlet_bloc.dart';
import 'features/payment/data/data_sources/payment_api_service.dart';
import 'features/payment/data/repository/payment_repository_impl.dart';
import 'features/payment/domain/repository/payment_repository.dart';
import 'features/payment/domain/usecases/confirm_payment.dart';
import 'features/payment/domain/usecases/get_payment.dart';
import 'features/payment/presentation/bloc/confirmation/confirmation_bloc.dart';
import 'features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'features/profile/data/data_sources/profile_api_service.dart';
import 'features/profile/data/data_sources/profile_point_api_service.dart';
import 'features/profile/data/repository/profile_point_repository_impl.dart';
import 'features/profile/data/repository/profile_repository_impl.dart';
import 'features/profile/domain/repository/profile_point_repository.dart';
import 'features/profile/domain/repository/profile_repository.dart';
import 'features/profile/domain/usecases/get_point_history.dart';
import 'features/profile/domain/usecases/update_profile.dart';
import 'features/profile/presentation/bloc/picture/picture_bloc.dart';
import 'features/profile/presentation/bloc/point/point_bloc.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/promo/data/data_sources/banner_api_service.dart';
import 'features/promo/data/data_sources/promo_api_service.dart';
import 'features/promo/data/repository/banner_repository_impl.dart';
import 'features/promo/data/repository/promo_repository_impl.dart';
import 'features/promo/domain/repository/banner_repository.dart';
import 'features/promo/domain/repository/promo_repository.dart';
import 'features/promo/domain/usecases/get_banner.dart';
import 'features/promo/domain/usecases/get_promo.dart';
import 'features/promo/domain/usecases/get_promo_list.dart';
import 'features/promo/presentation/bloc/banner/banner_bloc.dart';
import 'features/promo/presentation/bloc/promo/promo_bloc.dart';
import 'features/reservation/data/data_sources/reservation_api_service.dart';
import 'features/reservation/data/repository/reservation_repository_impl.dart';
import 'features/reservation/domain/repository/reservation_repository.dart';
import 'features/reservation/domain/usecases/apply_promo.dart';
import 'features/reservation/domain/usecases/create_reservation.dart';
import 'features/reservation/domain/usecases/get_payment_method.dart';
import 'features/reservation/domain/usecases/get_reservation_detail.dart';
import 'features/reservation/domain/usecases/get_reservations.dart';
import 'features/reservation/domain/usecases/get_tables.dart';
import 'features/reservation/presentation/bloc/payment_method/payment_method_bloc.dart';
import 'features/reservation/presentation/bloc/promo/reservation_promo_bloc.dart';
import 'features/reservation/presentation/bloc/reservation/reservation_bloc.dart';
import 'features/reservation/presentation/bloc/table/table_bloc.dart';

final sl = GetIt.instance;

GetIt get getIt => sl;

Future<void> initializeDependencies() async {
  // Dio
  final dio = buildDioClient();
  sl.registerSingleton<Dio>(dio);

  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // Dependencies
  sl.registerSingleton<AuthApiService>(AuthApiService(dio));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<PopupApiService>(
    () => PopupApiService(dio),
  );
  sl.registerLazySingleton<PopupRepository>(
    () => PopupRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<BannerApiService>(
    () => BannerApiService(dio),
  );
  sl.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<EventApiService>(
    () => EventApiService(dio),
  );
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<OutletApiService>(
    () => OutletApiService(dio),
  );
  sl.registerLazySingleton<OutletRepository>(
    () => OutletRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<NewsApiService>(
    () => NewsApiService(dio),
  );
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<PromoApiService>(
    () => PromoApiService(dio),
  );
  sl.registerLazySingleton<PromoRepository>(
    () => PromoRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ComplaintApiService>(
    () => ComplaintApiService(dio),
  );
  sl.registerLazySingleton<ComplaintRepository>(
    () => ComplaintRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(dio),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<MembershipApiService>(
    () => MembershipApiService(dio),
  );
  sl.registerLazySingleton<MembershipRepository>(
    () => MembershipRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<CouponApiService>(
    () => CouponApiService(dio),
  );
  sl.registerLazySingleton<CouponRepository>(
    () => CouponRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ReservationApiService>(
    () => ReservationApiService(dio),
  );
  sl.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<PaymentApiService>(
    () => PaymentApiService(dio),
  );
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ProfilePointApiService>(
    () => ProfilePointApiService(dio),
  );
  sl.registerLazySingleton<ProfilePointRepository>(
    () => ProfilePointRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton<CheckEmailUseCase>(
    () => CheckEmailUseCase(sl()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl()),
  );
  sl.registerLazySingleton<GetPopupUseCase>(
    () => GetPopupUseCase(sl()),
  );
  sl.registerLazySingleton<GetBannerUseCase>(
    () => GetBannerUseCase(sl()),
  );
  sl.registerLazySingleton<GetEventUseCase>(
    () => GetEventUseCase(sl()),
  );
  sl.registerLazySingleton<GetEventsUseCase>(
    () => GetEventsUseCase(sl()),
  );
  sl.registerLazySingleton<GetTodayEventUseCase>(
    () => GetTodayEventUseCase(sl()),
  );
  sl.registerLazySingleton<GetOutletDetailsUseCase>(
    () => GetOutletDetailsUseCase(sl()),
  );
  sl.registerLazySingleton<GetNewsUseCase>(
    () => GetNewsUseCase(sl()),
  );
  sl.registerLazySingleton<GetNewsListUseCase>(
    () => GetNewsListUseCase(sl()),
  );
  sl.registerLazySingleton<GetPromoUseCase>(
    () => GetPromoUseCase(sl()),
  );
  sl.registerLazySingleton<GetPromoListUseCase>(
    () => GetPromoListUseCase(sl()),
  );
  sl.registerLazySingleton<GetComplaintTypesUseCase>(
    () => GetComplaintTypesUseCase(sl()),
  );
  sl.registerLazySingleton<SendComplaintUseCase>(
    () => SendComplaintUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl()),
  );
  sl.registerLazySingleton<GetMembershipUseCase>(
    () => GetMembershipUseCase(sl()),
  );
  sl.registerLazySingleton<GetCouponsUseCase>(
    () => GetCouponsUseCase(sl()),
  );
  sl.registerLazySingleton<GetCouponUseCase>(
    () => GetCouponUseCase(sl()),
  );
  sl.registerLazySingleton<GetMyCouponUseCase>(
    () => GetMyCouponUseCase(sl()),
  );
  sl.registerLazySingleton<BuyCouponUseCase>(
    () => BuyCouponUseCase(sl()),
  );
  sl.registerLazySingleton<ApplyPromoUseCase>(
    () => ApplyPromoUseCase(sl()),
  );
  sl.registerLazySingleton<CreateReservationUseCase>(
    () => CreateReservationUseCase(sl()),
  );
  sl.registerLazySingleton<GetReservationsUseCase>(
    () => GetReservationsUseCase(sl()),
  );
  sl.registerLazySingleton<GetReservationDetailUseCase>(
    () => GetReservationDetailUseCase(sl()),
  );
  sl.registerLazySingleton<GetTablesUseCase>(
    () => GetTablesUseCase(sl()),
  );
  sl.registerLazySingleton<GetPaymentMethodsUseCase>(
    () => GetPaymentMethodsUseCase(sl()),
  );
  sl.registerLazySingleton<GetPaymentUseCase>(
    () => GetPaymentUseCase(sl()),
  );
  sl.registerLazySingleton<ConfirmPaymentUseCase>(
    () => ConfirmPaymentUseCase(sl()),
  );
  sl.registerLazySingleton<GetPointHistoryUseCase>(
    () => GetPointHistoryUseCase(sl()),
  );

  // Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl(), sl(), sl()),
  );
  sl.registerFactory<PopupBloc>(
    () => PopupBloc(sl()),
  );
  sl.registerFactory<BannerBloc>(
    () => BannerBloc(sl()),
  );
  sl.registerFactory<EventBloc>(
    () => EventBloc(sl(), sl(), sl()),
  );
  sl.registerFactory<OutletBloc>(
    () => OutletBloc(sl()),
  );
  sl.registerFactory<NewsBloc>(
    () => NewsBloc(sl(), sl()),
  );
  sl.registerFactory<PromoBloc>(
    () => PromoBloc(sl(), sl()),
  );
  sl.registerFactory<ComplaintTypeBloc>(
    () => ComplaintTypeBloc(sl()),
  );
  sl.registerFactory<ComplaintBloc>(
    () => ComplaintBloc(sl()),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(sl()),
  );
  sl.registerFactory<ProfilePictureBloc>(
    () => ProfilePictureBloc(),
  );
  sl.registerFactory<MembershipBloc>(
    () => MembershipBloc(sl()),
  );
  sl.registerFactory<CouponBloc>(
    () => CouponBloc(sl(), sl(), sl()),
  );
  sl.registerFactory<CouponPurchasedBloc>(
    () => CouponPurchasedBloc(sl()),
  );
  sl.registerFactory<TableBloc>(
    () => TableBloc(sl()),
  );
  sl.registerFactory<ReservationBloc>(
    () => ReservationBloc(sl(), sl(), sl()),
  );
  sl.registerFactory<ReservationPromoBloc>(
    () => ReservationPromoBloc(sl()),
  );
  sl.registerFactory<PaymentBloc>(
    () => PaymentBloc(sl()),
  );
  sl.registerFactory<ConfirmationPaymentBloc>(
    () => ConfirmationPaymentBloc(sl()),
  );
  sl.registerFactory<PaymentMethodBloc>(
    () => PaymentMethodBloc(sl()),
  );
  sl.registerFactory<PointBloc>(
    () => PointBloc(sl()),
  );
}
