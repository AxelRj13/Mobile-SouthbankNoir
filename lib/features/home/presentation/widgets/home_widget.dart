import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southbank/features/membership/presentation/bloc/membership_bloc.dart';
import 'package:southbank/features/membership/presentation/bloc/membership_event.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/components/refresh_indicator.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../events/presentation/bloc/event_bloc.dart';
import '../../../events/presentation/bloc/event_event.dart';
import '../../../events/presentation/bloc/event_state.dart';
import '../../../events/presentation/widgets/event_today.dart';
import '../../../events/presentation/widgets/today_event_title.dart';
import '../../../promo/presentation/bloc/banner/banner_bloc.dart';
import '../../../promo/presentation/bloc/banner/banner_event.dart';
import '../../../promo/presentation/bloc/banner/banner_state.dart';
import '../../../promo/presentation/widgets/carousel.dart';
import 'header.dart';
import 'menu.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _userName = '-';

  @override
  void initState() {
    super.initState();

    final prefs = getIt.get<SharedPreferences>();

    _userName = prefs.getString('firstName') ?? '-';
  }

  @override
  Widget build(BuildContext context) {
    return SBRefreshIndicator(
      onRefresh: () async {
        context.read<MembershipBloc>().add(const GetMembership());
        context.read<BannerBloc>().add(const GetBanner());
        context.read<EventBloc>().add(const GetTodayEvent());
      },
      items: [
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
                    Logout(),
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
        BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerDone) {
              return BannerCarousel(banners: state.banners!);
            }

            if (state is BannerError) {
              return const Center(
                child: Icon(Icons.refresh),
              );
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: const Center(child: SBLoading()),
            );
          },
        ),
        // const BannerCarousel(),
        const SizedBox(height: 50.0),
        const Menu(),
        const SizedBox(height: 50.0),
        BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventsDone) {
              return EventToday(events: state.events!);
            }

            if (state is EventError) {
              return const Center(
                child: Icon(Icons.refresh),
              );
            }

            if (state is EventNotFound) {
              return const EventToday();
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const TodayEventTitle(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: const Center(child: SBLoading()),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
