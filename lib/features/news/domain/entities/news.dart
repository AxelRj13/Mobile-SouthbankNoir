import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String? title;
  final String? description;
  final String? createdAt;
  final String? image;

  const NewsEntity({
    this.title,
    this.description,
    this.createdAt,
    this.image,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        createdAt,
        image,
      ];
}
