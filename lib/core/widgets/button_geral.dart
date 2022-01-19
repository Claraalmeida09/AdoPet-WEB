import 'package:adopet/core/values/colors_adopet.dart';
import 'package:adopet/core/values/text_style_adopet.dart';
import 'package:flutter/material.dart';

class ButtonGeral extends StatelessWidget {
  const ButtonGeral({
    required this.text,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.onPressed,
    required this.color,
    this.borderColor,
    required this.icon,
    this.iconAdd,
  });

  final String text;
  final double width;
  final double height;
  final Function() onPressed;
  final double fontSize;
  final Color color;
  final Color? borderColor;
  final bool icon;
  final IconData? iconAdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor ?? color),
          borderRadius: BorderRadius.circular(
            50,
          ),
        ),
        width: width,
        height: height,
        child: Center(
          child: icon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconAdd,
                      color: ColorsAdoPet.white,
                    ),
                    Text(
                      text,
                      style: TextStyleAdoPet.textButton,
                    ),
                  ],
                )
              : Text(
                  text,
                  style: TextStyleAdoPet.textButton,
                ),
        ),
      ),
    );
  }
}
