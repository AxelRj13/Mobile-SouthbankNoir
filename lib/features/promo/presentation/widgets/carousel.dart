import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/components/loading.dart';
import '../../domain/entities/banner.dart';
import '../bloc/banner/banner_bloc.dart';
import '../bloc/banner/banner_state.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Widget _buildCarousel(List<BannerEntity> banners) {
    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        height: 200.0,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
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
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: banner.bannerImage != null
                          ? NetworkImage(banner.bannerImage!)
                          : const AssetImage('assets/img/logo.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildCarouselIndicator(List<BannerEntity> banners) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: banners.asMap().entries.map((banner) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black)
                .withOpacity(_current == banner.key ? 0.9 : 0.4),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerDone) {
          return Column(
            children: [
              _buildCarousel(state.banners!),
              _buildCarouselIndicator(state.banners!),
            ],
          );
        }

        if (state is BannerError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }

        return const SBLoading();
      },
    );
  }
}
