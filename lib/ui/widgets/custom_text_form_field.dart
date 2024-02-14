import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final double verticalPadding;
  final String? value;
  final Icon? suffixIcon;
  final bool showLabel;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.verticalPadding = 10.0,
    this.value,
    this.suffixIcon,
    this.showLabel = true,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (showLabel) ...[
          Text(
            hintText.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
              color: Color(0xFF9CA4AA),
            ),
          ),
          const SizedBox(height: 7.0),
        ],
        TextFormField(
          key: key,
          initialValue: value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: 15.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.grey[400]!,
            ),
          ),
        ),
      ],
    );
  }
}
