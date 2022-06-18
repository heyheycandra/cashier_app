import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:cashier_app_mobile/helper/biscuit.dart';
import 'package:cashier_app_mobile/model/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthLogin) {
          var biscuit = Biscuit();
          User? loginModel = await biscuit.getUser();

          if (kDebugMode) {
            print('Checking Shared Preferences');
          }
          if (loginModel != null) {
            if (kDebugMode) {
              print('Shared Preferences is Exist');
            }
            emit(AuthLoggedIn(loginModel));
          } else {
            if (kDebugMode) {
              print('Shared Preferences Not Found');
            }
            emit(AuthLoggedOut());
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(AuthError(e.toString()));
      }
    });
  }
}
