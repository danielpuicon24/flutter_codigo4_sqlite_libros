import 'package:flutter/material.dart';

class InputIcon extends StatelessWidget {

  Icon icon;
  Function onPressed;

  InputIcon({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Color(0xff4c4f5e),
      shape: const CircleBorder(),
      child: icon,
      constraints: const BoxConstraints.tightFor(width: 50.0, height: 50.0),
      onPressed: (){
        onPressed();
      },
    );
  }
}