import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/image_header.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/error/general_error.dart';
import '../../../../core/error/not_found.dart';
import '../../data/models/promo.dart';
import '../bloc/promo/promo_bloc.dart';
import '../bloc/promo/promo_event.dart';
import '../bloc/promo/promo_state.dart';

class PromoDetail extends StatefulWidget {
  final String id;

  const PromoDetail({super.key, required this.id});

  @override
  State<PromoDetail> createState() => _PromoDetailState();
}

class _PromoDetailState extends State<PromoDetail> {
  Widget buildInformationComponent({
    required IconData icon,
    required String label,
    required String information,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  icon,
                  size: 20.0,
                  color: accentColor,
                ),
              ),
              const WidgetSpan(
                child: SizedBox(width: 8.0),
              ),
              TextSpan(text: label),
            ],
          ),
        ),
        Text(information),
      ],
    );
  }

  Widget buildPromo(PromoModel promo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInformationComponent(
            icon: Icons.calendar_month,
            label: 'Promo Period',
            information: promo.promoDate!,
          ),
          const SizedBox(height: 10.0),
          buildInformationComponent(
            icon: Icons.payments,
            label: 'Minimum Spend',
            information: promo.minimumSpend!,
          ),
          const SizedBox(height: 25.0),
          Text(promo.description!),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PromoBloc>().add(GetPromo(id: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromoBloc, PromoState>(
      builder: (context, state) {
        if (state is PromoLoading) {
          return const Center(child: SBLoading());
        }

        if (state is PromoError) {
          return const Center(child: GeneralErrorWidget(isDetail: true));
        }

        if (state is PromoDone) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SBImageHeader(image: state.promo!.image),
                buildPromo(state.promo!),
              ],
            ),
          );
        }

        return const Center(child: NotFoundWidget());
      },
    );
  }
}
