import 'package:equatable/equatable.dart';

class MessageResponse extends Equatable {
  final bool status;
  final String title;
  final String message;

  const MessageResponse({
    required this.status,
    required this.title,
    required this.message,
  });

  @override
  List<Object?> get props => [status, title, message];
}
