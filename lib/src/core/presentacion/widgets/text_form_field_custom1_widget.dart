import 'package:flutter/material.dart';

class TextFormFieldCustom1 extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool enabled;
  final String? errorMesagge;
  final Color colorError;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  TextFormFieldCustom1({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.obscureText = false,
    this.enabled = true,
    this.errorMesagge,
    this.colorError = const Color(0xFFC62828),
    this.onChanged,
    this.validator,
    this.prefixIcon,
  });
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    var colorPrimary = color.primary;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    );
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabled: enabled,
        disabledBorder: border.copyWith(
          borderSide: BorderSide(color: colorPrimary),
        ),
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colorPrimary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colorError),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colorError),
        ),
        focusColor: colorPrimary,
        errorText: errorMesagge,
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: colorPrimary.withOpacity(0.1),
        prefixIcon: prefixIcon,
        prefixIconColor: colorPrimary,
      ),
    );
  }
}
