import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:cashier_app_mobile/helper/app_exception.dart';
import 'package:cashier_app_mobile/helper/biscuit.dart';
import 'package:cashier_app_mobile/model/user.dart';
import 'package:cashier_app_mobile/services/restapi.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  User blocUser = User();
  RestApi api = RestApi();
  Biscuit biscuit = Biscuit();
  UserBloc() : super(UserInitial()) {
    if (kDebugMode) {
      print("entered");
    }
    on<UserEvent>(
      (event, emit) async {
        emit(UserLoading());
        try {
          if (event is RegisterUser) {
            String msg = await register(event.user);
            emit(RegisterComplete(msg));
          } else if (event is LoginUser) {
            await login(event.user);
            await biscuit.saveUser(blocUser);
            emit(LoginComplete());
          } else if (event is CheckUser) {
            User? loginModel = await biscuit.getUser();
            if (loginModel != null && loginModel.accessToken != null) {
              blocUser = await getActualUser(loginModel.accessToken!);
              emit(UserLoaded(blocUser));
            } else {
              throw InvalidSessionExpression("There are no biscuits in this app");
            }
          } else if (event is UpdateUser) {
            User? loginModel = await biscuit.getUser();
            if (loginModel != null && loginModel.accessToken != null) {
              var response = await api.updateProfile(token: loginModel.accessToken ?? "", body: event.model.toMap()) as Map<String, dynamic>;
              var user = User.map(response['data']);
              user.accessToken = loginModel.accessToken;
              biscuit.saveUser(user);
              emit(UpdateComplete(response['message'], user));
            } else {
              throw InvalidSessionExpression("There are no biscuits in this app");
            }
          } else if (event is UpdatePass) {
            User? loginModel = await biscuit.getUser();
            if (loginModel != null && loginModel.accessToken != null) {
              var response = await api.updatePassword(token: loginModel.accessToken ?? "", body: {
                'user_id': (loginModel.id ?? "").toString(),
                'password': event.pass,
                'password_confirmation': event.confirmPass,
              }) as Map<String, dynamic>;
              emit(UpdatePassComplete(response['message']));
            } else {
              throw InvalidSessionExpression("There are no biscuits in this app");
            }
          } else if (event is DoLogoutUser) {
            User? loginModel = await biscuit.getUser();
            if (loginModel != null && loginModel.accessToken != null) {
              await api.logout(
                token: loginModel.accessToken ?? "",
                body: {
                  'user_id': (loginModel.id ?? "").toString(),
                },
              ) as Map<String, dynamic>;
              biscuit.dbClear();
              emit(LogoutUser());
            } else {
              throw InvalidSessionExpression("There are no biscuits in this app");
            }
          }
        } catch (e) {
          if (e is InvalidSessionExpression) {
            biscuit.dbClear();
            emit(LogoutUser());
          } else {
            emit(UserError(e.toString()));
          }
        }
      },
    );
  }

  Future<String> register(User user) async {
    var response = await api.register(body: user.toRegister()) as Map;
    if (response['pesan'] is String) {
      return response['pesan'];
    } else {
      return "Berhasil";
    }
  }

  login(User user) async {
    var loginResponse = await api.login(body: user.toLogin()) as Map<String, dynamic>;
    String token = loginResponse['token'];
    var userResponse = await api.getUser(token: 'Bearer $token') as Map<String, dynamic>;
    blocUser = User.map(userResponse);
    blocUser.accessToken = 'Bearer $token';
  }

  Future<User> getActualUser(String token) async {
    var userResponse = await api.getUser(token: token) as Map<String, dynamic>;
    return User.map(userResponse);
  }
}
