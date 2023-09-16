import '../../domain/entities/banner.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    String? id,
    String? title,
    String? bannerImage,
    String? startDate,
  }) : super(
          id: id,
          title: title,
          bannerImage: bannerImage,
          startDate: startDate,
        );

  factory BannerModel.fromJson(Map<String, dynamic> data) {
    return BannerModel(
      id: data['id'],
      title: data['title'],
      bannerImage: data['banner_image'],
      startDate: data['start_date'],
    );
  }
}
