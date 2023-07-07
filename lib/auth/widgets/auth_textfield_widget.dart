import 'package:flutter/material.dart';

import 'package:summer_project/utils/textfield_validator.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final Function(String value)? onChanged;
  bool isPassword;
  final bool isEmail;
  final bool isName;
  final bool isConfirmPassword;
  final TextEditingController textEditingController;
  final String? password;
  final String hintText;
  Icon? prefixIcon;
  TextInputType textInputType;
  AuthTextFieldWidget({
    Key? key,
    this.onChanged,
    this.isPassword = false,
    this.isEmail = false,
    this.isName = false,
    this.isConfirmPassword = false,
    required this.textEditingController,
    this.password = '',
    required this.hintText,
    this.prefixIcon,
    required this.textInputType,
  }) : super(key: key);

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.isPassword
          ? passwordValidator
          : widget.isEmail
              ? emailValidator
              : widget.isName
                  ? nameValidator
                  : validator,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputBorder,
        filled: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword || widget.isConfirmPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                icon: const Icon(
                  Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword || widget.isConfirmPassword,
    );
  }
}
