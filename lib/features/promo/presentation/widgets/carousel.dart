import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../config/routes/router.dart';
import '../../data/models/banner.dart';

class BannerCarousel extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerCarousel({
    super.key,
    required this.banners,
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Widget buildCarousel(List<BannerModel> banners) {
    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        viewportFraction: 1,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      items: banners
          .map(
            (banner) => Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    router.pushNamed(
                      'promoDetail',
                      pathParameters: {'promoId': banner.id!},
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            banner.bannerImage != null ? NetworkImage(banner.bannerImage!) : const AssetImage('assets/img/logo.png') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }

  Widget buildCarouselIndicator(List<BannerModel> banners) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: banners.asMap().entries.map((banner) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_current == banner.key ? 0.9 : 0.4),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCarousel(widget.banners),
        buildCarouselIndicator(widget.banners),
      ],
    );
  }
}
