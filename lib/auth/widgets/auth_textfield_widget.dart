import 'package:flutter/material.dart';

import 'package:summer_project/utils/textfield_validator.dart';

class AuthTextFieldWidget extends StatelessWidget {
  Function(String value)? onChanged;
  final bool isPassword;
  final bool isEmail;
  final bool isName;
  final bool isConfirmPassword;
  final TextEditingController textEditingController;
  final String hintText;
  final Icon? prefixIcon;
  TextInputType textInputType;
  AuthTextFieldWidget({
    Key? key,
    this.onChanged,
    this.isPassword = false,
    this.isEmail = false,
    this.isName = false,
    this.isConfirmPassword = false,
    required this.textEditingController,
    required this.hintText,
    this.prefixIcon,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      onChanged: onChanged,
      validator: isPassword
          ? passwordValidator
          : isEmail
              ? emailValidator
              : isName
                  ? nameValidator
                  : validator,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputBorder,
        filled: true,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPassword || isConfirmPassword,
    );
  }
}
