import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/image_header.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/error/not_found.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_event.dart';
import '../bloc/event_state.dart';

class EventDetail extends StatefulWidget {
  final String id;

  const EventDetail({super.key, required this.id});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  Widget _buildInfo({required IconData icon, required String label, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  content,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventBloc>().add(GetEvent(id: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Center(
            child: SBLoading(),
          );
        }

        if (state is EventDone) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SBImageHeader(image: state.event!.image),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Text(
                  state.event!.name!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Flexible(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      height: constraints.maxHeight,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                        ),
                        color: appbarColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildInfo(icon: Icons.person, label: 'Artist', content: state.event!.artist!),
                            _buildInfo(icon: Icons.calendar_today, label: 'Date & Time', content: state.event!.dateStart!),
                            _buildInfo(icon: Icons.pin_drop, label: 'Location', content: state.event!.storeName!),
                            _buildInfo(icon: Icons.info, label: 'Description', content: state.event!.description!),
                            const SizedBox(height: 30.0),
                            SBButton(
                              onPressed: () {
                                router.goNamed('reservation', queryParameters: {
                                  'rsvpDate': state.event!.rsvpDate,
                                });
                              },
                              child: const Text('Reserve'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const Center(
          child: NotFoundWidget(message: 'The event you are looking for was not found'),
        );
      },
    );
  }
}
