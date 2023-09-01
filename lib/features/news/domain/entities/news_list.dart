import 'package:equatable/equatable.dart';

class NewsListEntity extends Equatable {
  final String? id;
  final String? title;
  final String? createdAt;
  final String? image;

  const NewsListEntity({
    this.id,
    this.title,
    this.createdAt,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        image,
      ];
}
