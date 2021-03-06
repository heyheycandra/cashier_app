// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constant extends InheritedWidget {
  static Constant? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Constant>();

  const Constant({required Widget child, Key? key}) : super(key: key, child: child);

  //MENUS
  static const String MENU_LOGIN = "MENU_LOGIN";
  static const String MENU_REGISTER = "MENU_REGISTER";
  static const String MENU_DASHBOARD = "MENU_DASHBOARD";
  static const String MENU_CART = 'MENU_CART';
  static const String MENU_HISTORY = "MENU_HISTORY";
  static const String MENU_TICKET = "MENU_TICKET";
  static const String BARCODE_SCREEN = "BARCODE_SCREEN";
  static const String ORDER_DETAIL = "ORDER_DETAIL";
  static const String PAYMENT = "PAYMENT";

  //FORMS
  static const String FORM_TICKET = "FORM_TICKET";

  //for API

  //form Mode
  static const String FORM_MODE = 'formMode';
  static const String FORM_MODE_VIEW = 'VIEW';
  static const String FORM_MODE_EDIT = 'EDIT';
  static const String FORM_MODE_ADD = 'ADD';

  //Actions
  static const String ACTION_DELETE = 'DELETE';
  static const String MODEL = "MODEL";

  //settings

  //form uploads

  //Base64Tester
  static const String Base64ImageTester =
      "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";

  @override
  bool updateShouldNotify(Constant oldWidget) => false;
}

extension StringExtension on String {
  String capitalize() {
    // ignore: unnecessary_this
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
