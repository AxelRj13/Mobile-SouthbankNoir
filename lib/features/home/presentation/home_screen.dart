import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/dialog.dart';
import '../../../injection_container.dart';
import '../../events/presentation/bloc/event_bloc.dart';
import '../../events/presentation/bloc/event_event.dart';
import '../../promo/presentation/bloc/banner/banner_bloc.dart';
import '../../promo/presentation/bloc/banner/banner_event.dart';
import 'bloc/popup_bloc.dart';
import 'bloc/popup_event.dart';
import 'bloc/popup_state.dart';
import 'widgets/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PopupBloc>().add(const GetPopup());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopupBloc, PopupState>(
      listener: (context, state) async {
        if (state is PopupDone) {
          await popupDialog(context, context.read<PopupBloc>().state.popup!.image!);
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BannerBloc>(
            create: (BuildContext context) => getIt.get<BannerBloc>()..add(const GetBanner()),
          ),
          BlocProvider<EventBloc>(
            create: (BuildContext context) => getIt.get<EventBloc>()..add(const GetTodayEvent()),
          ),
        ],
        child: const HomeWidget(),
      ),
    );
  }
}
