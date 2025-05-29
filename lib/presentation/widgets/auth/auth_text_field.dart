// lib/presentation/widgets/auth/auth_text_field.dart
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.icon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        // Hereda los estilos del tema automáticamente
      ),
    );
  }
}
