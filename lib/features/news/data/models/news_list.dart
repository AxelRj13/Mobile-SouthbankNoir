import '../../domain/entities/news_list.dart';

class NewsListModel extends NewsListEntity {
  const NewsListModel({
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

  factory NewsListModel.fromJson(Map<String, dynamic> data) => NewsListModel(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        createdAt: data['created_at'] ?? '',
        image: data['image'] ?? '',
      );
}
