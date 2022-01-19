import 'package:adopet/core/values/colors_adopet.dart';
import 'package:flutter/material.dart';

class ColumnForm extends StatelessWidget {
  const ColumnForm(
      {Key? key,
      required this.text,
      this.obrigatory,
      required this.widget,
      required this.style})
      : super(key: key);
  final String text;
  final String? obrigatory;
  final Widget widget;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: text,
            style: style,
            children: [
              TextSpan(
                text: obrigatory,
                style: const TextStyle(
                  color: ColorsAdoPet.obrigatory,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        widget
      ],
    );
  }
}
