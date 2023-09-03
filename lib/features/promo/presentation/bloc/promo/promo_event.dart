abstract class PromoEvent {
  const PromoEvent();
}

class GetPromoList extends PromoEvent {
  const GetPromoList();
}

class GetPromo extends PromoEvent {
  final String id;

  const GetPromo({required this.id});
}
