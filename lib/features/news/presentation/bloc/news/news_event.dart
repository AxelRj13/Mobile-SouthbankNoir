abstract class NewsEvent {
  const NewsEvent();
}

class GetNewsList extends NewsEvent {
  const GetNewsList();
}

class GetNews extends NewsEvent {
  final String id;

  const GetNews({required this.id});
}
