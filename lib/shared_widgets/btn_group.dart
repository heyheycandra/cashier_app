import 'package:flutter/material.dart';

class ButtonPermission extends StatelessWidget {
  final Function()? onTap;
  final String? text;

  const ButtonPermission({this.onTap, this.text, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        key: UniqueKey(),
        height: 35,
        child: ButtonTheme(
          buttonColor: const Color(0xff2DB5BA),
          disabledColor: const Color(0xffC0C0C0),
          child: TextButton(
            onPressed: onTap,
            child: Text(
              text ?? "",
              style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonDialogPreview extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final Color? colors;

  const ButtonDialogPreview({Key? key, this.onTap, this.text, this.colors}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
        height: 35,
        child: ButtonTheme(
          disabledColor: const Color(0xffC0C0C0),
          buttonColor: colors ?? const Color(0xff2DB5BA),
          child: TextButton(
            onPressed: onTap,
            child: Text(
              text ?? "",
              style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonDialogPreview2 extends StatelessWidget {
  final String? text;
  final Color? colors;
  final Function()? onTap;

  const ButtonDialogPreview2({this.text, this.colors, this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
      height: 35,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 4,
      ),
      child: ButtonTheme(
        disabledColor: colors,
        buttonColor: colors,
        child: TextButton(
          onPressed: onTap,
          child: Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          ),
        ),
      ),
    );
  }
}

class ButtonGroups2 extends StatelessWidget {
  final String? text;
  final Color? colors;
  final Function()? onTap;

  const ButtonGroups2({this.text, this.colors, this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 11, right: 16, left: 16),
      height: 20,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 4,
      ),
      child: ButtonTheme(
        disabledColor: colors,
        buttonColor: colors,
        child: TextButton(
          onPressed: onTap,
          child: Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          ),
        ),
      ),
    );
  }
}
