

import 'package:flutter/material.dart';

class LoginFormTitle extends StatelessWidget {
   const LoginFormTitle({
    Key? key,
  }) : super(key: key);

  final String titleText = "Event Manager Login";
  @override
  Widget build(BuildContext context) {
    return Text(titleText,style:const  TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
  }
}

class LoginFormTextItem extends StatelessWidget {
  const LoginFormTextItem({
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.obsecureText = false,
    
    Key? key,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final bool obsecureText;
  final TextEditingController controller; 
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller ,
      obscureText:obsecureText,
      validator: (value) {
        bool isNotEmpty = FormValidator.isNotEmpty(value);
        if(!isNotEmpty){
          return "$hintText field is required";
        }
      },
       decoration:InputDecoration(
        filled: true,
        hintText: hintText,
        labelText: labelText,
        fillColor: const Color.fromARGB(255, 242, 241, 241)
       ),
    );
  }
}

class FormValidator {
  static bool isNotEmpty(String? value){
    if(value?.isNotEmpty == true){
      return true;
    }else {
      return false;
    }
  }
}