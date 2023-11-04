import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/dialog.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/components/text_form_field.dart';
import '../../domain/entities/reservation_table_detail.dart';
import '../bloc/promo/reservation_promo_bloc.dart';
import '../bloc/promo/reservation_promo_event.dart';
import '../bloc/promo/reservation_promo_state.dart';
import '../bloc/reservation/reservation_bloc.dart';
import '../bloc/reservation/reservation_state.dart';

class ConfirmationWidget extends StatefulWidget {
  final String bookingId;

  const ConfirmationWidget({super.key, required this.bookingId});

  @override
  State<ConfirmationWidget> createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  final _formKey = GlobalKey<FormState>();
  final _promoController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
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

  Widget buildSubtotal({
    required String quantity,
    required String discount,
    required String payment,
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
        buildInformation(
          label: 'Payment',
          value: payment,
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

          _nameController.text = reservationDetail.contactPersonName!;
          _phoneController.text = reservationDetail.contactPersonPhone!;

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
                          buildTitle(
                            textTheme: theme.textTheme,
                            label: 'Subtotal',
                          ),
                          BlocBuilder<ReservationPromoBloc, ReservationPromoState>(
                            builder: (context, state) {
                              String discount = reservationDetail.totalDiscount!;
                              String payment = reservationDetail.totalPayment!;

                              if (state is ReservationPromo) {
                                discount = state.applyPromo!.discount!;
                                payment = state.applyPromo!.payment!;
                              }

                              return buildSubtotal(
                                quantity: reservationDetail.qty!,
                                discount: discount,
                                payment: payment,
                              );
                            },
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitle(
                            textTheme: theme.textTheme,
                            label: 'Promo Code',
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SBTextFormField(
                                  controller: _promoController,
                                  hintText: '',
                                  fillColor: Colors.black12,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  onChanged: (value) {
                                    _promoController.value = TextEditingValue(
                                      text: value.toUpperCase(),
                                      selection: _promoController.selection,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              BlocBuilder<ReservationPromoBloc, ReservationPromoState>(builder: (context, state) {
                                return TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(accentColor),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ReservationPromoBloc>(context).add(
                                      SetApplyPromo(
                                        bookingId: widget.bookingId,
                                        code: _promoController.text,
                                      ),
                                    );
                                  },
                                  child: (state is ReservationPromoLoading)
                                      ? const Center(
                                          child: SBLoading(color: Colors.white),
                                        )
                                      : const Text(
                                          'Apply',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                );
                              }),
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
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTitle(
                              textTheme: theme.textTheme,
                              label: 'Contact Person',
                            ),
                            const Text('Name'),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Expanded(
                                  child: SBTextFormField(
                                    controller: _nameController,
                                    hintText: '',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill in the name field';
                                      }
                                      return null;
                                    },
                                    fillColor: Colors.black12,
                                    contentPadding: const EdgeInsets.all(10.0),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            const Text('Phone No.'),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Expanded(
                                  child: SBTextFormField(
                                    controller: _phoneController,
                                    hintText: '',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill in the phone number field';
                                      }
                                      return null;
                                    },
                                    fillColor: Colors.black12,
                                    contentPadding: const EdgeInsets.all(10.0),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                            label: 'Additional Notes',
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SBTextFormField(
                                  controller: _notesController,
                                  hintText: 'e.g. : Please turn down AC temperature a bit, etc...',
                                  fillColor: Colors.black12,
                                  contentPadding: const EdgeInsets.all(10.0),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  isMultiline: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SBButton(
                      onPressed: (state is ReservationLoading)
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                comingsoonDialog(context);
                              }
                            },
                      child: (state is ReservationLoading)
                          ? const Center(
                              child: SBLoading(color: Colors.white),
                            )
                          : const Text('Proceed to Payment'),
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
