import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_1/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_1/models/book.dart';
import 'package:flutter_codigo4_sqflite_1/pages/new_book.dart';
import 'package:flutter_codigo4_sqflite_1/widgets/item_book_list_widge.dart';
import 'package:flutter_codigo4_sqflite_1/widgets/input_textfield_widget.dart';
import 'package:flutter_codigo4_sqflite_1/widgets/item_slider_favourite.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'example_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToastSuccess(String mensaje) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(mensaje),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );


  }

  _showToastInformation(String mensaje) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.lightBlue,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(mensaje),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );


  }

  showAddBookForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          backgroundColor: Color(0xff14213d),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Agregar libro",
                    style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextInputWdiget(
                    controller: _titleController,
                    title: "Title",
                    urlImage: "assets/icons/title.svg",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextInputWdiget(
                    controller: _authorController,
                    title: "Author",
                    urlImage: "assets/icons/author.svg",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextInputWdiget(
                    controller: _descriptionController,
                    lines: 3,
                    title: "Description",
                    urlImage: "assets/icons/list.svg",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextInputWdiget(
                    controller: _imageController,
                    title: "Image",
                    urlImage: "assets/icons/image.svg",
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white70),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xfff72585),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: () {
                      Book mynewBook = Book(
                        title: _titleController.text,
                        author: _authorController.text,
                        description: _descriptionController.text,
                        image: _imageController.text,
                        favourite: "false",
                      );

                      DBAdmin.db.insertBook(mynewBook);
                      Navigator.pop(context);
                      _showToastSuccess("Libro registrado correctamente");
                      setState(() {
                        resetData();
                      });
                    },
                    child: Text("Agregar"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }


  showEditBookForm(Book book) {
    Book _book = book;
    _titleController = new TextEditingController(text: _book.title);
    _authorController = new TextEditingController(text: _book.author);
    _descriptionController = new TextEditingController(text: _book.description);
    _imageController = new TextEditingController(text: _book.image);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          // insetPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          backgroundColor: Color(0xff14213d),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Editar libro",
                    style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextInputWdiget(
                    controller: _titleController,
                    title: "Title",
                    urlImage: "assets/icons/title.svg",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextInputWdiget(
                    controller: _authorController,
                    title: "Author",
                    urlImage: "assets/icons/author.svg",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextInputWdiget(
                    controller: _descriptionController,
                    lines: 3,
                    title: "Description",
                    urlImage: "assets/icons/list.svg",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextInputWdiget(
                    controller: _imageController,
                    title: "Image",
                    urlImage: "assets/icons/image.svg",
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white70),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xfff72585),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: () {
                      Book myBook = Book(
                        id: _book.id,
                        title: _titleController.text,
                        author: _authorController.text,
                        description: _descriptionController.text,
                        image: _imageController.text,
                        favourite: _book.favourite,
                      );

                      updateDataBook(myBook);
                      Navigator.pop(context);
                      _showToastSuccess("Libro editado correctamente");
                      setState(() {
                        resetData();
                      });
                    },
                    child: Text("Editar"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  showDeleteBook(Book book){
    Book _book = book;

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            // insetPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            backgroundColor: Color(0xfff72585),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(
                "¿Deseas eliminar este libro?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                            color: Colors.white70
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff14213d),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        deleteBook(_book.id);
                        Navigator.pop(context);
                        _showToastInformation("Libro eliminado correctamente");
                        setState(() {
                          resetData();
                        });
                      },
                      child: Text("Si, eliminar"),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }

  Future<void> updateDataBook(Book book) async {
    String title = _titleController.text;
    String author = _authorController.text;
    String description = _descriptionController.text;
    String image = _imageController.text;

    Book _book = book;

    _book.title = title;
    _book.author = author;
    _book.description = description;
    _book.image = image;

    await DBAdmin.db.updateBook(_book);

    resetData();
    setState(() {});
  }

  Future<void> addORDeleteFavourite(int? id, String result) async {

    result == "true" ? await DBAdmin.db.updateIsNotFavouriteBook(id)
        : await DBAdmin.db.updateIsFavouriteBook(id);

    setState(() {});
  }

  Future<void> deleteBook(int? id) async {

    await DBAdmin.db.deleteBook(id);

    setState(() {});
  }

  void resetData() {
    _titleController.clear();
    _authorController.clear();
    _descriptionController.clear();
    _imageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffffc300),
        onPressed: () {
          /*Book myBook = Book(
            title: "El conde de Montecristo",
            author: "Alejandro Dumas",
            description: "El conde de Montecristo (en francés, Le comte de Montecristo) es una novela de aventuras clásica de Alexandre Dumas (padre). Esta obra se suele considerar como el mejor trabajo de Dumas, y a menudo se incluye en las listas de las mejores novelas de todos los tiempos",
            image: "https://www.poemas-del-alma.com/blog/wp-content/uploads/2019/11/conde-montecristo-400x583.jpg",
            favourite: "false",
          );
          Book myBook2 = Book(
            title: "1984",
            author: "George Orwell",
            description:
            "1984 (en su versión original en inglés: Nineteen Eighty-Four) es una novela política de ficción distópica, escrita por George Orwell entre 1947 y 1948 y publicada el 8 de junio de 1949.",
            image:
            "https://images.cdn1.buscalibre.com/fit-in/360x360/10/42/10426f9e9ae4f7cd9eb5d33cef5aa143.jpg",
            favourite: "true",
          );
          // DBAdmin.db.insertBookRaw(myBook);
          // DBAdmin.db.insertBook(myBook);
          DBAdmin.db.insertBook(myBook);
          DBAdmin.db.insertBook(myBook2);*/

          showAddBookForm();
        },
        child: Icon(Icons.add),
      ),
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
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Buenos días",
                      style: GoogleFonts.comfortaa(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Mis Libros",
                      style: GoogleFonts.comfortaa(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Mis favoritos",
                      style: GoogleFonts.comfortaa(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: DBAdmin.db.getBooksFavourites(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          List<Book> books = snap.data;
                          return LimitedBox(
                            maxHeight: 250,
                            child: ListView.builder(
                              itemCount: books.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              // scrollDirection: Axis.horizontal,
                              //physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ItemSliderFavorite(
                                  title: books[index].title,
                                  author: books[index].author,
                                  imageURL: books[index].image,
                                );
                              },
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "General",
                      style: GoogleFonts.comfortaa(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                    FutureBuilder(
                      future: DBAdmin.db.getBooks(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          List<Book> books = snap.data;
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: books.length,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ItemBookListWidget(
                                  title: books[index].title,
                                  author: books[index].author,
                                  description: books[index].description,
                                  image: books[index].image,
                                  colors: books[index].favourite == "true" ? Colors.red : Colors.white.withOpacity(0.8),
                                  id:  books[index].id,
                                  function: () {
                                    //print(books[index].id);
                                    addORDeleteFavourite(books[index].id, books[index].favourite);
                                  },
                                  functionEdit: () {
                                     //updateDataBook(books[index]);
                                    showEditBookForm(books[index]);
                                  },
                                  functionDelete: () {
                                    showDeleteBook(books[index]);
                                    //deleteBook(books[index].id);
                                  },
                                );
                              },
                            )
                          ;
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 60.0,
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
