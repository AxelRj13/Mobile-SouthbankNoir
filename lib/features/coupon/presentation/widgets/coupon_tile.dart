import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/coupon_list.dart';

class CouponTileWidget extends StatelessWidget {
  final String tabIndex;
  final CouponListEntity coupon;

  const CouponTileWidget({
    super.key,
    required this.coupon,
    required this.tabIndex,
  });

  Widget imageWidget({
    Widget? child,
    ImageProvider? imageProvider,
    double? height,
  }) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: Container(
        width: double.maxFinite,
        height: height,
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

  Widget buildImage(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 4.75;

    return coupon.image == null || coupon.image == ''
        ? imageWidget(
            child: Icon(Icons.error, color: accentColor), height: height)
        : CachedNetworkImage(
            imageUrl: coupon.image!,
            imageBuilder: (context, imageProvider) =>
                imageWidget(imageProvider: imageProvider, height: height),
            progressIndicatorBuilder: (context, url, progress) => imageWidget(
                child: const Center(child: SBLoading()), height: height),
            errorWidget: (context, url, error) => imageWidget(
                child: Icon(Icons.error, color: accentColor), height: height),
          );
  }

  List<InlineSpan> _buildTextInformation(
    BuildContext context,
    bool isMyCoupon,
    CouponListEntity coupon,
  ) {
    final List<InlineSpan> info = [];

    String information = coupon.price ?? '';

    if (isMyCoupon) {
      information = '${coupon.startDate} - ${coupon.endDate}';

      info.addAll(
        [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(
              Icons.calendar_month,
              size: MediaQuery.of(context).size.width * 0.04,
              color: accentColor,
            ),
          ),
          const WidgetSpan(
            child: SizedBox(width: 5.0),
          ),
        ],
      );
    }

    info.add(
      TextSpan(
        text: information,
        style:
            Theme.of(context).textTheme.bodySmall!.copyWith(color: accentColor),
      ),
    );

    return info;
  }

  Widget buildTitleAndInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            coupon.name ?? '',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: _buildTextInformation(
                    context,
                    tabIndex == myCoupon,
                    coupon,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          router.goNamed(
            'couponDetail',
            pathParameters: {
              'type': tabIndex,
              'couponId': coupon.id!,
            },
          );
        },
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
      ),
    );
  }
}
