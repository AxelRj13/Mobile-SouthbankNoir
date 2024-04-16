import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/components/refresh_indicator.dart';
import '../../../../core/error/general_error.dart';
import '../../../../core/error/not_found.dart';
import '../bloc/reservation/reservation_bloc.dart';
import '../bloc/reservation/reservation_event.dart';
import '../bloc/reservation/reservation_state.dart';

class MyReservationWidget extends StatefulWidget {
  const MyReservationWidget({super.key});

  @override
  State<MyReservationWidget> createState() => _MyReservationWidgetState();
}

class _MyReservationWidgetState extends State<MyReservationWidget> {
  Widget imageWidget({
    required double width,
    Widget? child,
    ImageProvider? imageProvider,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: width * .4,
        height: width * .4,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          image: imageProvider != null
              ? DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: child,
      ),
    );
  }

  Widget buildImage({
    required double width,
    required String image,
  }) {
    return image == ''
        ? imageWidget(
            width: width,
            child: Icon(
              Icons.error,
              color: accentColor,
            ),
          )
        : CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => imageWidget(
              width: width,
              imageProvider: imageProvider,
            ),
            progressIndicatorBuilder: (context, url, progress) => imageWidget(
              width: width,
              child: const Center(
                child: SBLoading(),
              ),
            ),
            errorWidget: (context, url, error) => imageWidget(
              width: width,
              child: Icon(
                Icons.error,
                color: accentColor,
              ),
            ),
          );
  }

  Widget buildTitle({
    required TextTheme textTheme,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        label,
        style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildInformation({
    required TextTheme textTheme,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(label),
    );
  }

  Widget buildBadgeSign({
    required TextTheme textTheme,
    required String status,
  }) {
    Color colors;

    switch (status) {
      case 'Success':
        colors = Colors.green;
        break;
      case 'New':
        colors = accentColor;
        break;
      case 'Pending Payment':
        colors = accentColor;
        break;
      case 'Failed':
      case 'Expired':
        colors = Colors.red;
        break;
      default:
        colors = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        status,
        style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SBRefreshIndicator(
      onRefresh: () async {
        context.read<ReservationBloc>().add(const GetReservations());
      },
      items: [
        Center(
          child: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              if (state is ReservationNotFound) {
                return const NotFoundWidget();
              }

              if (state is ReservationError) {
                return const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: GeneralErrorWidget(),
                );
              }

              if (state is ReservationDone) {
                return Column(
                  children: state.reservations!.map((reservation) {
                    final theme = Theme.of(context);

                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(reservation.date!),
                          ),
                          ...reservation.bookings!.map(
                            (booking) => InkWell(
                              onTap: () {
                                if (booking.status == 'Success') {
                                  router.goNamed(
                                    'bookingDetail',
                                    pathParameters: {
                                      'bookingId': booking.bookingId!,
                                      'bookingNo': booking.bookingNo!,
                                    },
                                  );
                                } else if (booking.status == 'Pending Payment') {
                                  router.pushNamed(
                                    'payment',
                                    pathParameters: {
                                      'bookingId': booking.bookingId!,
                                    },
                                    queryParameters: {
                                      'redirectUrl': booking.redirectUrl,
                                    },
                                  );
                                } else {
                                  return;
                                }
                              },
                              child: Card(
                                margin: const EdgeInsets.all(10.0),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: accentColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final width = constraints.maxWidth;

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          buildBadgeSign(
                                            status: booking.bookingNo!,
                                            textTheme: theme.textTheme,
                                          ),
                                          const SizedBox(height: 10.0),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              buildImage(
                                                width: width,
                                                image: booking.storeImage!,
                                              ),
                                              const SizedBox(width: 15.0),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTitle(
                                                      textTheme: theme.textTheme,
                                                      label: booking.storeName!,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 10.0),
                                                      child: Text(
                                                        'Created: ${booking.createdDate!}',
                                                        style: const TextStyle(color: Colors.grey),
                                                      ),
                                                    ),
                                                    buildInformation(
                                                      textTheme: theme.textTheme,
                                                      label: booking.tableName!,
                                                    ),
                                                    buildInformation(
                                                      textTheme: theme.textTheme,
                                                      label: booking.tableCapacity!,
                                                    ),
                                                    buildInformation(
                                                      textTheme: theme.textTheme,
                                                      label: 'Event: ${booking.events ?? '-'}',
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          const TextSpan(text: 'Status:'),
                                                          const WidgetSpan(
                                                            child: SizedBox(width: 5.0),
                                                          ),
                                                          WidgetSpan(
                                                            alignment: PlaceholderAlignment.middle,
                                                            child: buildBadgeSign(
                                                              status: booking.status!,
                                                              textTheme: theme.textTheme,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          if (booking.expiryDate != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Center(
                                                child: Text(
                                                  'Please complete the payment before: ${booking.expiryDate}',
                                                  style: const TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
