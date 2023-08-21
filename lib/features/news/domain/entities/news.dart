import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String? id;
  final String? title;
  final String? createdAt;
  final String? image;

  const NewsEntity({
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
