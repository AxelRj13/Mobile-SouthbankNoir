import '../../domain/entities/news.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    String? title,
    String? description,
    String? createdAt,
    String? image,
  }) : super(
          title: title,
          description: description,
          createdAt: createdAt,
          image: image,
        );

  factory NewsModel.fromJson(Map<String, dynamic> data) => NewsModel(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        createdAt: data['created_at'] ?? '',
        image: data['image'] ?? '',
      );
}
