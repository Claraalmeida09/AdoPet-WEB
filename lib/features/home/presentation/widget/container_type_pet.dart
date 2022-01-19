import 'package:adopet/core/values/colors_adopet.dart';

import 'package:flutter/material.dart';

class ContainerTypePet extends StatelessWidget {
  const ContainerTypePet({Key? key, required this.widget, required this.onTap})
      : super(key: key);
  final Widget widget;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: MediaQuery.of(context).size.height * .30,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(width: 3.0, color: ColorsAdoPet.header),
            borderRadius: const BorderRadius.all(
                Radius.circular(5.0) //                 <--- border radius here
                ),
          ),
          child: Center(child: widget)),
    );
  }
}
