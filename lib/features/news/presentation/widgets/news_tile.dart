import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/news.dart';

class NewsTileWidget extends StatelessWidget {
  final NewsEntity news;

  const NewsTileWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print('Tapped');
      },
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: 14,
          end: 14,
          bottom: 7,
          top: 7,
        ),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    Widget imageWidget({required Widget child}) {
      return Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: 10.0, horizontal: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: child,
        ),
      );
    }

    return news.image!.isEmpty
        ? imageWidget(
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
              child: const Icon(Icons.error),
            ),
          )
        : CachedNetworkImage(
            // TODO: hosting image not found
            imageUrl: 'https://c.biztoc.com/p/03bafec89d455c7f/s.webp',
            imageBuilder: (context, imageProvider) => imageWidget(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, progress) => imageWidget(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                ),
                child: const CupertinoActivityIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => imageWidget(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                ),
                child: const Icon(Icons.error),
              ),
            ),
          );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Expanded(
              child: SizedBox.shrink(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Posted',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(news.createdAt ?? '-'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    print('News Detail');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(accentColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text('See more >'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
