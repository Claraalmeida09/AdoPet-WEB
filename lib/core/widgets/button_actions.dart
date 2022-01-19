import 'package:adopet/core/values/colors_adopet.dart';
import 'package:flutter/material.dart';

class ButtonsActions extends StatelessWidget {
  const ButtonsActions({
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final Function() onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        width: 31.64,
        height: 28,
        child: Center(
          child: Icon(icon, size: size, color: ColorsAdoPet.white),
        ),
      ),
    );
  }
}
