import 'package:equatable/equatable.dart';

class PromoEntity extends Equatable {
  final String? title;
  final String? description;
  final String? promoDate;
  final String? image;
  final String? minimumSpend;
  final String? code;

  const PromoEntity({
    this.title,
    this.description,
    this.promoDate,
    this.image,
    this.minimumSpend,
    this.code,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        promoDate,
        image,
        minimumSpend,
        code,
      ];
}
