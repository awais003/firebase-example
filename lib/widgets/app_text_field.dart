

import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
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
          onFieldSubmitted: nextFocusNode != null? (v) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          } : null,
          decoration: InputDecoration(
            prefixIcon: icon != null? Icon(
              icon,
              color: Colors.deepPurple,
            ) : null,
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
