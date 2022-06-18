import 'package:flutter/material.dart';

const Color kDarkGray = Color(0xFFA3A3A3);
const EdgeInsets _defaultInsetPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0);

class Dialog extends StatelessWidget {
  final Color? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets? insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final Widget? child;
  const Dialog({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.child,
  }) : super(key: key);

  static const RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)));
  static const double _defaultElevation = 24.0;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final EdgeInsets effectivePadding = MediaQuery.of(context).viewInsets + (insetPadding ?? const EdgeInsets.all(0.0));
    return AnimatedPadding(
      padding: effectivePadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280.0),
            child: Material(
              color: backgroundColor ?? dialogTheme.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
              elevation: elevation ?? dialogTheme.elevation ?? _defaultElevation,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              type: MaterialType.card,
              clipBehavior: clipBehavior,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
