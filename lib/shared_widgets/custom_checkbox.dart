import 'package:flutter/material.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';
import 'package:styled_text/styled_text.dart';
import 'package:cashier_app_mobile/theme/colors.dart';

class CustomCheckBoxListTile extends StatefulWidget {
  final String? title;
  final bool? value;
  final bool enabled;
  final bool? mandatory;
  final Function(bool)? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const CustomCheckBoxListTile({this.title, required this.enabled, this.value, this.onChanged, this.mandatory, this.contentPadding, Key? key})
      : super(key: key);
  @override
  _CustomCheckBoxListTileState createState() => _CustomCheckBoxListTileState();
}

class _CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  bool secondaryValue = false;
  @override
  void initState() {
    if (widget.value != null) secondaryValue = widget.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: widget.contentPadding,
      controlAffinity: ListTileControlAffinity.leading,
      value: secondaryValue,
      title: widget.mandatory != null && widget.mandatory!
          ? StyledText(
              text: widget.title ?? '<Title>',
              style: TextStyle(fontSize: context.scaleFont(14)),
              tags: {'r': StyledTextTag(style: TextStyle(fontSize: context.scaleFont(14), color: cashierDanger))},
            )
          : Text(
              widget.title ?? '<Title>',
              style: TextStyle(fontSize: context.scaleFont(14)),
            ),
      // subtitle: Text(widget.subtitle),
      onChanged: (value) {
        if (widget.enabled && value != null) {
          setState(() {
            secondaryValue = value;
          });
          if (widget.onChanged != null) widget.onChanged!(value);
        }
      },
    );
  }
}
