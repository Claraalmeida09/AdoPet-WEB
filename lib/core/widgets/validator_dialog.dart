import 'package:adopet/core/values/images_adopet.dart';
import 'package:adopet/core/values/text_style_adopet.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:flutter/material.dart';

class ValidatorDialog extends StatelessWidget {
  const ValidatorDialog({
    Key? key,
    required this.canSaveList,
    required this.title,
    required this.subtitle,
    required this.text,
  }) : super(key: key);
  final List<Widget> canSaveList;
  final String title;
  final String subtitle;
  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(subtitle),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: canSaveList.map((e) => e).toList(),
      ),
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  ImagesAdoPet.gifDog,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 250,
                  height: 100,
                  child: Text(
                    text,
                    style: TextStyleAdoPet.titleYellow,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Image.asset(
                  ImagesAdoPet.gifCat,
                  width: 150,
                  height: 150,
                ),
              ],
            ),
            TextButton(
              child: const Text(TextsAdoPet.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
