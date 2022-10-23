

import 'package:flutter/material.dart';


class ListRowIcon extends StatelessWidget {
   ListRowIcon({
    Key? key,
    required this.iconData,
    required this.size,
    this.iconSize = 15,
    this.iconColor = Colors.black,
    required this.press,
  }) : super(key: key);

  final Size size;
  final IconData iconData;
  Color iconColor;
  double iconSize;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints:const BoxConstraints(),
      onPressed: press,
      icon: Icon(iconData,size: iconSize,color: iconColor,)
    );
  }
}