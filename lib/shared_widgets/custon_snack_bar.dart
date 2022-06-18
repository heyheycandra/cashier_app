import 'package:flutter/material.dart';
import 'package:cashier_app_mobile/theme/colors.dart';

successSnackBar(String? message) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message ?? 'OK',
      style: const TextStyle(color: cashierWhite, fontSize: 16),
    ),
    backgroundColor: cashierSuccess,
  );
}

failSnackBar(String? message) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message ?? 'GAGAL',
      style: const TextStyle(color: cashierWhite, fontSize: 16),
    ),
    backgroundColor: cashierWarning,
  );
}

functionSnackbar({String? message, Color? color, required Function() onAccept}) {
  return SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message ?? '',
      style: const TextStyle(color: cashierWhite, fontSize: 16),
    ),
    action: SnackBarAction(
      label: 'Oke',
      textColor: cashierWhite,
      onPressed: onAccept,
    ),
    backgroundColor: color,
  );
}
