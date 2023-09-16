import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String? id;
  final String? title;
  final String? bannerImage;
  final String? startDate;

  const BannerEntity({
    this.id,
    this.title,
    this.bannerImage,
    this.startDate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        bannerImage,
        startDate,
      ];
}
