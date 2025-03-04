import 'dart:io';

abstract class UserEvent{

}

class SignInWithGoogleEvent extends UserEvent{

}

class GetUserEvent extends UserEvent{

}

class SignOutEvent extends UserEvent{

}

class EditProfileEvent extends UserEvent{
  final String name;
  final String bio;
  final File? avatar;

  EditProfileEvent({required this.name, required this.bio, this.avatar});
}