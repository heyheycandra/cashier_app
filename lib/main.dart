import 'package:cashier_app_mobile/helper/locator.dart';
import 'package:cashier_app_mobile/helper/navigator_service.dart';
import 'package:cashier_app_mobile/helper/route_generator.dart';
import 'package:cashier_app_mobile/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: locator<NavigatorService>().navigatorKey,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      home: const LoginScreen(),
    );
  }
}
