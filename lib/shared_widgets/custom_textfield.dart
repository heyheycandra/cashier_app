import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cashier_app_mobile/theme/colors.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';

class CustomFormTextField extends StatelessWidget {
  final String? hint, label;
  final Function(String?)? onChanged, onAction;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputformat;
  final FocusNode? focusNode;
  final bool? readOnly, enabled;
  final int? maxLine, maxLength;
  final Widget? suffix;
  final String? errorMessage;

  const CustomFormTextField(
      {Key? key,
      this.hint,
      this.label,
      this.validator,
      this.onChanged,
      this.onAction,
      this.inputType,
      this.inputAction,
      this.focusNode,
      this.readOnly,
      this.onTap,
      this.controller,
      this.inputformat,
      this.enabled,
      this.maxLine,
      this.maxLength,
      this.suffix,
      this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enableInteractiveSelection: this.inputType != TextInputType.number,
      inputFormatters: inputType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
      readOnly: readOnly ?? false,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: inputType,
      maxLength: maxLength,
      maxLines: maxLine,
      // inputFormatters: inputformat,
      textInputAction: inputAction,
      onFieldSubmitted: onAction,
      onTap: onTap,
      style: const TextStyle(color: cashierMainText, fontSize: 15),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 12, color: cashierDanger),
        errorText: errorMessage,
        counterText: '',
        suffixIcon: suffix,
        // suffixText: validator != null ? '*' : '',
        // suffixStyle: TextStyle(
        //   fontSize: context.scaleFont(14),
        //   color: cashierDanger,
        // ),
        enabled: enabled ?? true,
        labelText: label,
        labelStyle: TextStyle(
            fontSize: context.scaleFont(14),
            color: (enabled == null)
                ? cashierMainText
                : enabled!
                    ? cashierMainText
                    : cashierMainText),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 15),
        filled: true,
        fillColor: (enabled == null)
            ? cashierFillField
            : !enabled!
                ? cashierDisabledTextField
                : cashierFillField,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: cashierUnselect)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: cashierUnselect)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: cashierBlack, width: 1.8)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: cashierDanger)),
        focusedErrorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: cashierDanger, width: 1.8)),
      ),
    );
  }
}
