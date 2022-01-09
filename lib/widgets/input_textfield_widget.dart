import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputWdiget extends StatelessWidget {
  int? lines;
  String title;
  String urlImage;
  TextEditingController controller;

  TextInputWdiget(
      {required this.title,
      required this.urlImage,
      this.lines,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
      ),
      maxLines: lines,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: GoogleFonts.comfortaa(color: Colors.white60, fontSize: 14.0,),
        filled: true,
        fillColor: Color(0xff203157),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        prefixIcon: SvgPicture.asset(
          urlImage,
          color: Colors.white,
          height: 10.0,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
