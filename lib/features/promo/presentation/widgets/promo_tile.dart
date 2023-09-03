import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/loading.dart';
import '../../domain/entities/promo_list.dart';

class PromoTileWidget extends StatelessWidget {
  final PromoListEntity promo;

  const PromoTileWidget({super.key, required this.promo});

  Widget buildImage(BuildContext context) {
    Widget imageWidget({
      Widget? child,
      ImageProvider? imageProvider,
    }) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height / 4.75,
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

    return promo.image == null || promo.image == ''
        ? imageWidget(
            child: Icon(Icons.error, color: accentColor),
          )
        : CachedNetworkImage(
            imageUrl: promo.image!,
            imageBuilder: (context, imageProvider) => imageWidget(
              imageProvider: imageProvider,
            ),
            progressIndicatorBuilder: (context, url, progress) => imageWidget(
              child: const Center(child: SBLoading()),
            ),
            errorWidget: (context, url, error) => imageWidget(
              child: Icon(Icons.error, color: accentColor),
            ),
          );
  }

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

  Widget buildTitleAndInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            promo.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          const Divider(),
          const SizedBox(height: 8.0),
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
          const SizedBox(height: 20.0),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minimumSize: const Size.fromHeight(40),
            ),
            child: const Text(
              'View Details',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              router.goNamed(
                'promoDetail',
                pathParameters: {'promoId': promo.id!},
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
      height: MediaQuery.of(context).size.height / 2.2,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            buildImage(context),
            buildTitleAndInformation(context),
          ],
        ),
      ),
    );
  }
}
