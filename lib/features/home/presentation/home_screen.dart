import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/dialog.dart';
import '../../../injection_container.dart';
import '../../auth/presentation/bloc/auth/remote/auth_bloc.dart';
import '../../auth/presentation/bloc/auth/remote/auth_event.dart';
import '../../events/presentation/bloc/event_bloc.dart';
import '../../events/presentation/bloc/event_event.dart';
import '../../events/presentation/widgets/event_today.dart';
import '../../promo/presentation/bloc/banner/banner_bloc.dart';
import '../../promo/presentation/bloc/banner/banner_event.dart';
import '../../promo/presentation/widgets/carousel.dart';
import 'bloc/popup_bloc.dart';
import 'bloc/popup_event.dart';
import 'bloc/popup_state.dart';
import 'widgets/header.dart';
import 'widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = '-';

  @override
  void initState() {
    super.initState();
    final prefs = getIt.get<SharedPreferences>();

    _userName = prefs.getString('name') ?? '-';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PopupBloc>().add(const GetPopup());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopupBloc, PopupState>(
      listener: (context, state) {
        if (state is PopupDone) {
          popupDialog(context, context.read<PopupBloc>().state.popup!.image!);
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BannerBloc>(
            create: (BuildContext context) =>
                getIt.get<BannerBloc>()..add(const GetBanner()),
          ),
          BlocProvider<EventBloc>(
            create: (BuildContext context) =>
                getIt.get<EventBloc>()..add(const GetTodayEvent()),
          ),
        ],
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, $_userName",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          SignOut(),
                        );
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Header(),
              ),
              const SizedBox(height: 20.0),
              const BannerCarousel(),
              const SizedBox(height: 50.0),
              const Menu(),
              const SizedBox(height: 50.0),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: EventToday(
                  isTodayEvent: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
