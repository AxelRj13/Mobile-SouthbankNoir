import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_client.dart';
import 'features/auth/data/data_sources/remote/auth_api_service.dart';
import 'features/auth/data/repository/login_repository_impl.dart';
import 'features/auth/data/repository/register_repository_impl.dart';
import 'features/auth/domain/repository/login_repository.dart';
import 'features/auth/domain/repository/register_repository.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/bloc/auth/remote/auth_bloc.dart';
import 'features/events/data/data_sources/remote/event_api_service.dart';
import 'features/events/data/repository/event_repository_impl.dart';
import 'features/events/domain/repository/event_repository.dart';
import 'features/events/domain/usecases/get_event.dart';
import 'features/events/domain/usecases/get_today_event.dart';
import 'features/events/presentation/bloc/event_bloc.dart';
import 'features/news/data/data_sources/remote/news_api_service.dart';
import 'features/news/data/repository/news_repository_impl.dart';
import 'features/news/domain/repository/news_repository.dart';
import 'features/news/domain/usecases/get_news.dart';
import 'features/news/presentation/bloc/news/remote/news_bloc.dart';
import 'features/promo/data/data_sources/remote/banner_api_service.dart';
import 'features/promo/data/repository/banner_repository_impl.dart';
import 'features/promo/domain/repository/banner_repository.dart';
import 'features/promo/domain/usecases/get_banner.dart';
import 'features/promo/presentation/bloc/banner/remote/banner_bloc.dart';

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
  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(sl()));
  sl.registerSingleton<RegisterRepository>(RegisterRepositoryImpl(sl()));

  sl.registerLazySingleton<BannerApiService>(() => BannerApiService(dio));
  sl.registerLazySingleton<BannerRepository>(() => BannerRepositoryImpl(sl()));

  sl.registerLazySingleton<EventApiService>(() => EventApiService(dio));
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(sl()));

  sl.registerLazySingleton<NewsApiService>(() => NewsApiService(dio));
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<GetBannerUseCase>(() => GetBannerUseCase(sl()));
  sl.registerLazySingleton<GetEventUseCase>(() => GetEventUseCase(sl()));
  sl.registerLazySingleton<GetTodayEventUseCase>(
      () => GetTodayEventUseCase(sl()));
  sl.registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<BannerBloc>(() => BannerBloc(sl()));
  sl.registerFactory<EventBloc>(() => EventBloc(sl(), sl()));
  sl.registerFactory<NewsBloc>(() => NewsBloc(sl()));
}
