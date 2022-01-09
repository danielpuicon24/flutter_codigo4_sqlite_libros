import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_1/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_1/models/book.dart';

class NewBookPage extends StatefulWidget {
  const NewBookPage({Key? key}) : super(key: key);

  @override
  _NewBookPageState createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _favouriteController = TextEditingController();
  bool isFavourite = false;

  void success(BuildContext listo) {
    showDialog(
      context: listo,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text("Libro"),
          backgroundColor: Colors.white,
          elevation: 0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Libro Guardado Correctamente"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _titleController.clear();
                _authorController.clear();
                _descriptionController.clear();
                _favouriteController.clear();
                this.isFavourite = false;
              },
              child: Text(
                "Listo",
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color(0XFF1D202B),
              Color(0XFF262A46),
            ])),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextInputWidget(
                      campo: "Title",
                      textController: _titleController,
                    ),
                    TextInputWidget(
                      campo: "Author",
                      textController: _authorController,
                    ),
                    TextInputWidget(
                      campo: "Description",
                      textController: _descriptionController,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0), color: Colors.white),
                      child: CheckboxListTile(
                        title: Text("Favourite"),
                        value: this.isFavourite,
                        onChanged: (newValue) {
                          setState(() {
                            this.isFavourite = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                    ),
                    MaterialButton(
                      color: Colors.greenAccent,
                      child: Text("Guardar"),
                      onPressed: () {
                        Book myNewBook = Book(
                          title: _titleController.text,
                          author: _authorController.text,
                          description:  _descriptionController.text,
                          image: "https://www.poemas-del-alma.com/blog/wp-content/uploads/2019/11/conde-montecristo-400x583.jpg",
                          favourite: this.isFavourite ? "true" : "false",
                        );
                        DBAdmin.db.insertBook(myNewBook);
                        success(context);
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextInputWidget extends StatelessWidget {
  String campo;
  TextEditingController textController;

  TextInputWidget({required this.campo, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0), color: Colors.white),
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: textController,
        decoration: InputDecoration(
          label: Text(campo),
          labelStyle: TextStyle(color: Colors.black, fontSize: 18.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.lightBlue,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.black38,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
