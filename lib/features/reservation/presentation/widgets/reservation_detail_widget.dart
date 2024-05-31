import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/loading.dart';
import '../../domain/entities/reservation_table_detail.dart';
import '../bloc/reservation/reservation_bloc.dart';
import '../bloc/reservation/reservation_state.dart';

class ReservationDetailWidget extends StatefulWidget {
  const ReservationDetailWidget({super.key});

  @override
  State<ReservationDetailWidget> createState() => _ReservationDetailWidgetState();
}

class _ReservationDetailWidgetState extends State<ReservationDetailWidget> {
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
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        label,
        style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildInformation({
    required String label,
    required String value,
    bool isBold = false,
    TextTheme? textTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold
                ? textTheme!.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : null,
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget buildTableDetails({
    required ReservationTableDetailEntity tableDetail,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          buildInformation(
            label: 'Table',
            value: tableDetail.tableName!,
          ),
          buildInformation(
            label: 'Capacity',
            value: tableDetail.capacity!,
          ),
          buildInformation(
            label: 'Down Payment',
            value: tableDetail.total!,
          ),
          buildInformation(
            label: 'Minimum Spend',
            value: tableDetail.minimumSpend!,
          ),
        ],
      ),
    );
  }

  Widget buildPaymentInformation({
    required String quantity,
    required String discount,
  }) {
    return Column(
      children: [
        buildInformation(
          label: 'Quantity',
          value: quantity,
        ),
        buildInformation(
          label: 'Discount',
          value: discount,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        if (state is ReservationDetail) {
          final theme = Theme.of(context);
          final reservationDetail = state.reservationDetailModel!;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
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

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildImage(
                                width: width,
                                image: reservationDetail.storeImage!,
                              ),
                              const SizedBox(width: 15.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildTitle(
                                      textTheme: theme.textTheme,
                                      label: reservationDetail.storeName!,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 15.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.middle,
                                              child: Icon(
                                                Icons.calendar_month,
                                                color: accentColor,
                                              ),
                                            ),
                                            const WidgetSpan(
                                              child: SizedBox(width: 5.0),
                                            ),
                                            TextSpan(
                                              text: reservationDetail.reservationDate,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text('Event: ${reservationDetail.events ?? '-'}'),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: accentColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitle(
                            textTheme: theme.textTheme,
                            label: 'Booking Details',
                          ),
                          ...reservationDetail.details!.map(
                            (tableDetail) => buildTableDetails(tableDetail: tableDetail),
                          ),
                          const Divider(
                            thickness: 2.0,
                            height: 30.0,
                          ),
                          const SizedBox(height: 15.0),
                          buildInformation(
                            label: 'Subtotal',
                            value: reservationDetail.subtotal!,
                            isBold: true,
                            textTheme: theme.textTheme,
                          ),
                          const SizedBox(height: 10.0),
                          buildPaymentInformation(
                            quantity: reservationDetail.qty!,
                            discount: reservationDetail.totalDiscount!,
                          ),
                          const SizedBox(height: 10.0),
                          buildInformation(
                            label: 'Total',
                            value: reservationDetail.totalPayment!,
                            isBold: true,
                            textTheme: theme.textTheme,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: accentColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTitle(
                                textTheme: theme.textTheme,
                                label: 'Contact Person Information',
                              ),
                              Text(reservationDetail.contactPersonName!),
                              const SizedBox(height: 8.0),
                              Text(reservationDetail.contactPersonPhone!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: accentColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTitle(
                                  textTheme: theme.textTheme,
                                  label: 'Additional Notes',
                                ),
                                Text('${reservationDetail.notes != '' && reservationDetail.notes != null ? reservationDetail.notes : '-'}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ReservationError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }

        return const Center(
          child: SBLoading(),
        );
      },
    );
  }
}
