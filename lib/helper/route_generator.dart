import 'package:cashier_app_mobile/shared_widgets/nav_header.dart';
import 'package:cashier_app_mobile/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app_mobile/helper/constant.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constant.MENU_LOGIN:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: navHeader('Error'),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ups, ada sesuatu yang salah. Coba lagi"),
            Container(
              margin: const EdgeInsets.all(4),
            ),
            GestureDetector(onTap: () {}, child: const Icon(Icons.refresh_outlined))
          ],
        )),
      );
    });
  }
}
