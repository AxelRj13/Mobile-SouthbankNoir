import '../../domain/entities/news.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    String? id,
    String? title,
    String? createdAt,
    String? image,
  }) : super(
          id: id,
          title: title,
          createdAt: createdAt,
          image: image,
        );

  factory NewsModel.fromJson(Map<String, dynamic> data) => NewsModel(
        id: data['id'] ?? 0,
        title: data['title'] ?? '',
        createdAt: data['created_at'] ?? '',
        image: data['image'] ?? '',
      );
}
