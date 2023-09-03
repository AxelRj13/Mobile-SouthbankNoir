import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';
import 'loading.dart';

class SBImageHeader extends StatelessWidget {
  final String? image;

  const SBImageHeader({super.key, this.image});

  Widget imageWidget({
    Widget? child,
    ImageProvider? imageProvider,
  }) {
    return Container(
      height: double.maxFinite,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: image == null || image == ''
          ? imageWidget(
              child: Icon(Icons.error, color: accentColor),
            )
          : CachedNetworkImage(
              imageUrl: image!,
              imageBuilder: (context, imageProvider) => imageWidget(
                imageProvider: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, progress) => imageWidget(
                child: const Center(child: SBLoading()),
              ),
              errorWidget: (context, url, error) => imageWidget(
                child: Icon(Icons.error, color: accentColor),
              ),
            ),
    );
  }
}
