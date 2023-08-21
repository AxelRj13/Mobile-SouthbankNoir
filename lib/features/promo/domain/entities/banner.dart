import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String? title;
  final String? bannerImage;
  final String? startDate;

  const BannerEntity({
    this.title,
    this.bannerImage,
    this.startDate,
  });

  @override
  List<Object?> get props => [
        title,
        bannerImage,
        startDate,
      ];
}
