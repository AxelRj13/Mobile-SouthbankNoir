import 'package:equatable/equatable.dart';

class PromoListEntity extends Equatable {
  final String? id;
  final String? title;
  final String? promoDate;
  final String? image;
  final String? minimumSpend;

  const PromoListEntity({
    this.id,
    this.title,
    this.promoDate,
    this.image,
    this.minimumSpend,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        promoDate,
        image,
        minimumSpend,
      ];
}
