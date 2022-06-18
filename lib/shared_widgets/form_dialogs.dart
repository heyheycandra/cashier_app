import 'package:flutter/material.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';
// import 'package:cashier_app_mobile/helper/constant.dart';
import 'package:cashier_app_mobile/helper/locator.dart';
import 'package:cashier_app_mobile/helper/navigator_service.dart';
import 'package:cashier_app_mobile/shared_widgets/buttons.dart';
import 'package:cashier_app_mobile/theme/colors.dart';

customWebDateRangePicker(BuildContext context, DateTime firstDate, DateTime lastDate, Function(DateTimeRange?) onSelect) {
  return showDateRangePicker(
    context: context,
    firstDate: firstDate,
    lastDate: lastDate,
    errorFormatText: 'Input MM/dd/yyyy',
    builder: (context, child) {
      return SizedBox(
        width: 400.0,
        height: 500.0,
        child: Center(
          child: Theme(
            data: ThemeData(
              primaryColor: cashierDanger,
              // primarySwatch: Colors.red,
            ),
            child: child!,
          ),
        ),
      );
    },
  ).then(onSelect);
}

customWebDatePicker(BuildContext context, DateTime initialDate, DateTime firstDate, DateTime lastDate, Function(DateTime?) onSelect) {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    fieldHintText: 'Input MM/dd/yyyy',
    errorFormatText: 'Input MM/dd/yyyy',
    builder: (context, child) {
      return SizedBox(
        width: 400.0,
        height: 500.0,
        child: Center(
          child: Theme(
            data: ThemeData(
              primaryColor: cashierDanger,
              // primarySwatch: Colors.red,
            ),
            child: child!,
          ),
        ),
      );
    },
  ).then(onSelect);
}

class DialogSuccess extends StatelessWidget {
  final String bodyText;
  final String buttonText;
  final Function() onTap;

  const DialogSuccess({required this.bodyText, required this.buttonText, required this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsetsDirectional.only(
                top: 16,
                start: 17,
                end: 17,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cashierGreen,
              ),
              child: Icon(
                Icons.check,
                size: context.scaleFont(50),
                color: cashierWhite,
              )),
          Container(
            margin: const EdgeInsetsDirectional.only(
              top: 16,
              start: 17,
              end: 17,
              bottom: 16,
            ),
            child: SelectableText(
              bodyText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: context.scaleFont(15), color: const Color(0xFF232020)),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              start: 17,
              end: 17,
              bottom: 10,
            ),
            child: ButtonConfirm(
              text: buttonText,
              width: MediaQuery.of(context).size.width / 2.1,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String? message;
  final bool isSuccess;
  final List<Widget> btnAction;

  const CustomAlertDialog({
    Key? key,
    required this.btnAction,
    this.message,
    required this.isSuccess,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          top: 20,
          start: 17,
          end: 17,
          bottom: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSuccess
                ? Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cashierGreen,
                    ),
                    child: Icon(
                      Icons.check,
                      size: context.scaleFont(50),
                      color: cashierWhite,
                    ))
                : Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cashierDanger,
                    ),
                    child: Icon(
                      Icons.priority_high,
                      size: context.scaleFont(50),
                      color: cashierWhite,
                    )),
            Container(
              margin: const EdgeInsetsDirectional.only(
                top: 16,
                bottom: 16,
              ),
              child: SelectableText(
                message ?? '-',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: context.scaleFont(15), color: const Color(0xFF232020)),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                bottom: 10,
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: btnAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

alertDialogLogout(
  BuildContext context,
  // Login? login,
  Function() onLogout,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          width: context.deviceWidth() / 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: 10,
                  start: 20,
                  end: 20,
                ),
                child: SelectableText(
                  'Apakah Anda yakin?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: context.scaleFont(14), color: const Color(0xFF232020)),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: 20,
                  start: 20,
                  end: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ButtonCancel(
                        text: 'Batal',
                        onTap: () {
                          locator<NavigatorService>().goBack();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ButtonConfirm(
                        text: 'Logout',
                        onTap: () {
                          locator<NavigatorService>().goBack();
                          onLogout();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
