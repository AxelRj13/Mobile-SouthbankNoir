import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/components/refresh_indicator.dart';
import '../../../../core/error/general_error.dart';
import '../../../../core/error/not_found.dart';
import '../bloc/point/point_bloc.dart';
import '../bloc/point/point_event.dart';
import '../bloc/point/point_state.dart';

class PointHistoryWidget extends StatefulWidget {
  const PointHistoryWidget({super.key});

  @override
  State<PointHistoryWidget> createState() => _PointHistoryWidgetState();
}

class _PointHistoryWidgetState extends State<PointHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SBRefreshIndicator(
      onRefresh: () async {
        context.read<PointBloc>().add(const GetPointHistory());
      },
      items: [
        Center(
          child: BlocBuilder<PointBloc, PointState>(
            builder: (context, state) {
              if (state is PointNotFound) {
                return const NotFoundWidget();
              }

              if (state is PointError) {
                return const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: GeneralErrorWidget(),
                );
              }

              if (state is PointDone) {
                return Column(
                  children: state.pointHistory!.map((point) {
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: accentColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        point.title!,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(point.details ?? '-'),
                                      const SizedBox(height: 10.0),
                                      Text(point.tableInfo ?? '-'),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        point.pointChange!,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                Text(
                                  point.latestPoint!,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Text(
                              point.createdDate!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }

              return const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SBLoading(),
              );
            },
          ),
        )
      ],
    );
  }
}
