abstract class ComplaintEvent {
  const ComplaintEvent();
}

class SendComplaint extends ComplaintEvent {
  final String type;
  final String date;
  final String store;
  final String description;

  const SendComplaint({
    required this.type,
    required this.date,
    required this.store,
    required this.description,
  });
}
