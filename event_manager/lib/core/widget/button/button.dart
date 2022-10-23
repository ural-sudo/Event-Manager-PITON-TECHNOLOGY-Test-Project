import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';

class ProjectButtons extends StatelessWidget {
   ProjectButtons({
    Key? key,
    this.size = Size.zero,
    required this.btnText,
    required this.press,
  }) : super(key: key);

  Size size;
  final String btnText;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          primary:ProjectColors.specialBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        onPressed:press,
        child:Text(btnText,style: const TextStyle(fontWeight: FontWeight.bold),)
      ),
    );
  }
}