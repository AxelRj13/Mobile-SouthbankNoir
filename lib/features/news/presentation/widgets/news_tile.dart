import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/loading.dart';
import '../../domain/entities/news_list.dart';

class NewsTileWidget extends StatelessWidget {
  final NewsListEntity news;

  const NewsTileWidget({super.key, required this.news});

  Widget buildImage(BuildContext context) {
    Widget imageWidget({
      Widget? child,
      ImageProvider? imageProvider,
    }) {
      return Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
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
          ),
        ),
      );
    }

    return news.image!.isEmpty
        ? imageWidget(
            child: Icon(Icons.error, color: accentColor),
          )
        : CachedNetworkImage(
            imageUrl: news.image!,
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

  Widget buildTitleAndDescription(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Posted',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                    ),
                    Text(
                      news.createdAt ?? '-',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'See more',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    router.goNamed(
                      'newsDetail',
                      pathParameters: {'newsId': news.id!},
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
      height: MediaQuery.of(context).size.width / 2.5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildImage(context),
          buildTitleAndDescription(context),
        ],
      ),
    );
  }
}
