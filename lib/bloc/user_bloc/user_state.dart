part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class RegisterComplete extends UserState {
  final String msg;
  RegisterComplete(this.msg);
}

class UpdateComplete extends UserState {
  final String msg;
  final User model;
  UpdateComplete(this.msg, this.model);
}

class UpdatePassComplete extends UserState {
  final String msg;
  UpdatePassComplete(
    this.msg,
  );
}

class LoginComplete extends UserState {
  LoginComplete();
}

class UserError extends UserState {
  final String error;
  UserError(this.error);
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(
    this.user,
  );
}

class LogoutUser extends UserState {}
