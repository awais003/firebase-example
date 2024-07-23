

import 'package:flutter/material.dart';

class AppPasswordField extends StatelessWidget {
  const AppPasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.focusNode,
    this.nextFocusNode,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.icon,
    this.error = "",
    required this.showPassword,
    required this.onShowPassword,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final IconData? icon;
  final String error;
  final bool showPassword;
  final Function onShowPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          focusNode: focusNode,
          obscureText: !showPassword,
          onFieldSubmitted: nextFocusNode != null? (v) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          } : null,
          decoration: InputDecoration(
            prefixIcon: icon != null? Icon(
              icon,
              color: Colors.deepPurple,
            ) : null,
            suffixIcon: IconButton(
              onPressed: () {
                onShowPassword();
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: !showPassword? Colors.grey : Colors.deepPurple,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: hint,
            error: error.isNotEmpty? Text(
              error,
              style: const TextStyle(
                  color: Colors.red
              ),
            ) : null,
          ),
        )
      ],
    );
  }
}
