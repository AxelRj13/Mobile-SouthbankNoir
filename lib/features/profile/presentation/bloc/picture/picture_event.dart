import 'dart:io';

abstract class ProfilePictureEvent {
  const ProfilePictureEvent();
}

class SetPhoto extends ProfilePictureEvent {
  final File image;

  const SetPhoto({required this.image});
}
