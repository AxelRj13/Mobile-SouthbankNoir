import '../../domain/entities/banner.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    String? title,
    String? bannerImage,
    String? startDate,
  }) : super(
          title: title,
          bannerImage: bannerImage,
          startDate: startDate,
        );

  factory BannerModel.fromJson(Map<String, dynamic> data) {
    return BannerModel(
      title: data['title'],
      bannerImage: data['banner_image'],
      startDate: data['start_date'],
    );
  }
}
