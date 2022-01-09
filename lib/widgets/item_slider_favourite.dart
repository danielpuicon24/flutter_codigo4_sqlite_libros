import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemSliderFavorite extends StatelessWidget {
  String title;
  String author;
  String imageURL;
  //"https://images-na.ssl-images-amazon.com/images/I/81vx-Br7niL.jpg"
  ItemSliderFavorite({
    required this.title, required this.author, required this.imageURL
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      imageURL),
                )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.comfortaa(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.comfortaa(
                  color: Colors.white54,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}