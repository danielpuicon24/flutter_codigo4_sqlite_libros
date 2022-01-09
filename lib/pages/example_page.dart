import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_1/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_1/models/book.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  String name = "Daniel Gonales";
  String nameFuture = "";

  void initState() {
    super.initState();

    getNameFuture().then((value) => nameFuture = value);

    getData();
  }

  void getData() async {
    int agex = await getAgePerson();
    print(agex);
  }

  String getName() {
    return "Elvis";
  }

  Future<String> getNameFuture() async {
    return Future.delayed(Duration(seconds: 2), () {
      return "Jose Danel";
    });
  }

  Future<List<String>> getListNames() async {
    return Future.delayed(Duration(seconds: 3), () {
      return [
        "Juan",
        "Luis",
        "Lilian",
        "Francisco",
      ];
    });
  }

  Future<int> getAgePerson() async {
    return 24;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: DBAdmin.db.getBooks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.connectionState);
          print(snapshot.error);
          print(snapshot.data);
          if (snapshot.hasData) {
            List<Book> books = snapshot.data;
            return ListView.builder(
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(books[index].title);
                });
            print(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    )
        /*Center(
        child: FutureBuilder(
          future: getNameFuture(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.connectionState);
            print(snapshot.error);
            print(snapshot.data);
            if(snapshot.hasData){
              return Text(snapshot.data);
            }
            return CircularProgressIndicator();
          },
        ),
      ),*/
        );
  }
}
