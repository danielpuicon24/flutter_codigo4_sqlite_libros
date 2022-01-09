import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_1/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_1/widgets/input_icon_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemBookListWidget extends StatelessWidget {
  String title;
  String author;
  String description;
  String image;
  Color? colors;
  int? id;
  Function function;
  Function functionEdit;
  Function functionDelete;

  ItemBookListWidget(
      {required this.title,
      required this.author,
      required this.description,
      required this.image,
      required this.colors,
      required this.function,
      required this.functionEdit,
      required this.functionDelete,
      this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 14.0,
      ),
      height: 100,
      child: Row(
        children: [
          Container(
            width: 70,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
            child: IconButton(

              onPressed: (){
                function();
              },
              icon: SvgPicture.asset(
                'assets/icons/bxs-heart.svg',
                color: colors,
                width: 35.0,
                height: 35.0,

              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.comfortaa(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    author,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),


                ],
              ),
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/edit.svg',
              color: Colors.white,
            ),
            onPressed: () {
              functionEdit();
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/trash.svg',
              color: Colors.white,
            ),
            onPressed: () {
              functionDelete();
            },
          ),
        ],
      ),
    );
  }
}
