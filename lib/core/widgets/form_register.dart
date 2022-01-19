import 'package:adopet/core/values/colors_adopet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormRegister extends StatelessWidget {
  const FormRegister({
    Key? key,
    this.formatters,
    this.controller,
    required this.obscureText,
    this.hintText,
    this.filled,
    this.color,
    required this.width,
    required this.enabled,
    this.validator,
    this.onChanged,
    this.onTap,
    required this.hintColor,
    required this.maxLines,
  }) : super(key: key);

  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? filled;
  final Color? color;
  final double width;
  final bool enabled;
  final bool obscureText;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final Color hintColor;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsAdoPet.yellowLogo),
      ),
      width: width,
      child: TextFormField(
        maxLines: maxLines,
        onChanged: onChanged,
        onTap: onTap,
        enabled: enabled,
        cursorColor: ColorsAdoPet.textColor,
        cursorHeight: 20,
        validator: validator,
        obscureText: obscureText,
        inputFormatters: formatters,
        controller: controller,
        decoration: InputDecoration(
          fillColor: color,
          filled: filled,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: hintColor,
          ),
        ),
      ),
    );
  }
}
