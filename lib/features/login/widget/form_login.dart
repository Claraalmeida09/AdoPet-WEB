import 'package:adopet/core/values/colors_adopet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    this.hintText,
    this.icon,
    required this.obscureText,
    this.validator,
    required this.controller,
    this.focusNode,
    this.nextFocus,
    this.enable,
    this.onChanged,
    this.formatters,
    this.maxLines,
  });

  final String? hintText;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool? enable;
  final Function(String?)? onChanged;
  final List<TextInputFormatter>? formatters;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      cursorColor: ColorsAdoPet.blueLogo,
      maxLines: maxLines,
      onChanged: onChanged,
      enabled: enable,
      focusNode: focusNode,
      style: const TextStyle(
        color: ColorsAdoPet.blueLogo,
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      inputFormatters: formatters,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        focusColor: ColorsAdoPet.greyHolder,
        contentPadding: const EdgeInsets.all(
          10,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: ColorsAdoPet.greyHolder),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: ColorsAdoPet.greyHolder),
        ),
        prefixIcon: Icon(
          icon,
          color: ColorsAdoPet.greyHolder,
          size: 24,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorsAdoPet.greyHolder,
        ),
      ),
    );
  }
}
