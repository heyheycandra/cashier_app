import 'package:flutter/material.dart';
import 'package:cashier_app_mobile/theme/colors.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';

class ButtonConfirm extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final double? width;

  const ButtonConfirm({this.text, this.onTap, this.width, Key? key}) : super(key: key);

  @override
  _ButtonConfirmState createState() => _ButtonConfirmState();
}

class _ButtonConfirmState extends State<ButtonConfirm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ButtonTheme(
        disabledColor: cashierUnselect,
        // buttonColor: cashierPrimary,
        child: TextButton(
          onPressed: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            // child: FittedBox(
            child: Text(
              widget.text ?? "",
              style: TextStyle(
                fontSize: context.scaleFont(14),
                color: widget.onTap != null ? cashierWhite : cashierBlack,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            // ),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                  // color: widget.onTap != null ? cashierPrimary : cashierDarkGray,
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular(50)),
            backgroundColor: widget.onTap != null ? cashierDarkGray : cashierUnselect,
            // primary: cashierPrimary,
          ),
        ),
      ),
    );
  }
}

class ButtonCancel extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final double? width;

  const ButtonCancel({this.text, this.onTap, this.width, Key? key}) : super(key: key);
  @override
  _ButtonCancelState createState() => _ButtonCancelState();
}

class _ButtonCancelState extends State<ButtonCancel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ButtonTheme(
        disabledColor: cashierUnselect,
        // buttonColor: cashierWhite,
        child: TextButton(
          onPressed: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: FittedBox(
              child: Text(
                widget.text ?? "",
                style: TextStyle(
                    fontSize: context.scaleFont(14), color: widget.onTap != null ? cashierPrimary : cashierBlack, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: widget.onTap != null ? cashierPrimary : cashierDarkGray, width: 1.8), borderRadius: BorderRadius.circular(8)),
            // primary: cashierWhite,
            backgroundColor: cashierWhite,
          ),
        ),
      ),
    );
  }
}

class ButtonConfirmWithIcon extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final IconData? icon;
  final double? width;

  const ButtonConfirmWithIcon({this.icon, this.text, this.onTap, this.width, Key? key})
      : assert(icon != null, text != null),
        super(key: key);

  @override
  _ButtonConfirmWithIconState createState() => _ButtonConfirmWithIconState();
}

class _ButtonConfirmWithIconState extends State<ButtonConfirmWithIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ButtonTheme(
        disabledColor: cashierUnselect,
        // buttonColor: cashierPrimary,
        child: TextButton.icon(
          onPressed: widget.onTap,
          icon: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Icon(
              widget.icon,
              color: widget.onTap != null ? cashierWhite : cashierBlack,
              size: context.scaleFont(15),
            ),
          ),
          label: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              widget.text ?? "",
              style: TextStyle(fontSize: 14, color: widget.onTap != null ? cashierWhite : cashierBlack, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: widget.onTap != null ? cashierTrafficYellow : cashierDarkGray, width: 1.8),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: widget.onTap != null ? cashierTrafficYellow : cashierDarkGray,
          ),
        ),
      ),
    );
  }
}
