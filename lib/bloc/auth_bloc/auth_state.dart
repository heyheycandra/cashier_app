part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User model;
  AuthLoggedIn(this.model);
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String errMsg;

  AuthError(this.errMsg);
}
