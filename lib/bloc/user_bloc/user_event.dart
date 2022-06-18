part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class RegisterUser extends UserEvent {
  final User user;
  RegisterUser({required this.user});
}

class LoginUser extends UserEvent {
  final User user;
  LoginUser({required this.user});
}

class CheckUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final User model;
  UpdateUser(this.model);
}

class UpdatePass extends UserEvent {
  final String pass;
  final String confirmPass;
  UpdatePass(this.pass, this.confirmPass);
}

class DoLogoutUser extends UserEvent {}
