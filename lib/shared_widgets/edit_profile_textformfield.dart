import 'package:flutter/material.dart';

class EditProfileTextFormField extends StatefulWidget {
  final String? label, hintText, returnVal, prefixLable, initialValue;
  final Color? prefixLableColor;
  final double? width;
  final int? minLines, maxLines;
  final double? keyboardHeight;
  final bool isPassword;
  final bool? readOnly;
  final TextInputType? keyboarType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? Function(String?)? onFieldSubmitted, onChange;
  final Function()? onTap, onTapText;
  final TextEditingController? controller;
  const EditProfileTextFormField(
      {this.label,
      this.isPassword = false,
      this.keyboardHeight,
      this.hintText,
      this.onChange,
      this.onTap,
      this.onFieldSubmitted,
      this.keyboarType,
      this.textInputAction,
      this.focusNode,
      this.returnVal,
      this.controller,
      this.readOnly,
      this.width,
      this.minLines,
      this.maxLines,
      this.prefixLable = "",
      this.initialValue,
      this.prefixLableColor = Colors.black,
      this.onTapText,
      Key? key})
      : super(key: key);
  @override
  _EditProfileTextFormFieldState createState() => _EditProfileTextFormFieldState();
}

class _EditProfileTextFormFieldState extends State<EditProfileTextFormField> {
  late bool _obsecure;
  @override
  void initState() {
    super.initState();
    _obsecure = widget.isPassword;
  }

  void _toggle() {
    setState(() {
      _obsecure = !_obsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label ?? "",
                  style: const TextStyle(fontSize: 14, color: Color(0xff2A4455), fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.prefixLable ?? "",
                  style: TextStyle(fontSize: 14, color: widget.prefixLableColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: widget.width ?? MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: widget.onTapText,
              child: TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  controller: widget.controller,
                  obscureText: _obsecure,
                  readOnly: widget.readOnly ?? false,
                  keyboardType: widget.keyboarType,
                  textInputAction: widget.textInputAction,
                  initialValue: widget.initialValue,
                  focusNode: widget.focusNode,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  // scrollPadding: EdgeInsets.symmetric(vertical: widget.keyboardHeight),
                  decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(fontSize: 14, color: Color(0xffB0B0B0)),
                      contentPadding: const EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xffF5F5F5),
                      suffixIcon: widget.isPassword
                          ? GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _toggle();
                              },
                              child: Icon(
                                _obsecure ? Icons.visibility_off : Icons.visibility,
                                color: _obsecure ? Colors.grey : Colors.blue,
                                size: 20,
                              ),
                            )
                          : const SizedBox()),
                  onChanged: widget.onChange,
                  onTap: widget.onTap,
                  validator: (value) {
                    return widget.returnVal;
                  }),
            ),
          )
        ],
      ),
    );
  }
}
