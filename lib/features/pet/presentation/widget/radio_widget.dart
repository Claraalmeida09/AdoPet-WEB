import 'package:adopet/core/values/colors_adopet.dart';
import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {
  const MyRadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    required this.fontSize,
    required this.widthContainer,
  });

  final T value;
  final T? groupValue;
  final String label;
  final ValueChanged<T?> onChanged;
  final double fontSize;
  final double widthContainer;

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return Container(
      width: widthContainer,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: isSelected ? ColorsAdoPet.yellowLogo : Colors.white,
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : ColorsAdoPet.yellowLogo,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: ColorsAdoPet.yellowLogo.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(),
            ],
          ),
        ),
      ),
    );
  }
}
