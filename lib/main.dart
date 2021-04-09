import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  modul_1 createState() => modul_1();
}

class modul_1 extends State<MyApp> {
  final List<String> todo = <String>[
    'tugas praktikum',
    'tugas basis data',
    'tugas web'
  ];

  String codeDialog;
  String valueText;
  bool showValue = false;
  bool selected = true;
  final List<bool> values = <bool>[false, false, false];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        textTheme: GoogleFonts.londrinaSolidTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6F8),
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 75,
          backgroundColor: Color(0xFFFF194350),
          title: Text('ToDo List', style: TextStyle(color: Color(0xFFFFffc2b4), fontSize: 25, fontWeight: FontWeight.w100, fontFamily: 'Londrina Solid')),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(4.0),
            itemCount: todo.length,
            itemBuilder: (BuildContext context, i) {
              if (values[i] == false) {
                return Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                            left: 5, top: 20, right: 5, bottom: 0),
                        height: 75,
                        color: Color(0xFFFFffd3b4),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 10.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: values[i],
                                  onChanged: (value) {
                                    setState(() {
                                      showValue = value;
                                      values[i] = !values[i];
                                      String first = todo.removeAt(i);
                                      bool firstValue = values.removeAt(i);
                                      values.insert(values.length, firstValue);
                                      todo.insert(todo.length, first);
                                    });
                                  },
                                  activeColor: Colors.black12,
                                ),
                                Text(todo[i],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ))),
                    line()
                  ],
                ));
              } else {
                return Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                            left: 5, top: 20, right: 5, bottom: 0),
                        height: 50,
                        color: Colors.white60,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 5.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: values[i],
                                  activeColor: Colors.black12,
                                ),
                                Text(todo[i],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ))),
                  ],
                ));
              }
            }),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.add,
            color: Color(0xFFFFffc2b4),
            size: 40,
          ),
          onPressed: () {
            TambahData(context);
          },
          elevation: 1,
          backgroundColor: Color(0xFFFF194350),
        ),
      ),
    );
  }

  //garis
  line() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 1.0,
          width: 130.0,
          color: Colors.black,
        ));
  }

  Future<void> TambahData(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Tambah list', style: TextStyle(fontFamily: 'Londrina Solid', fontWeight: FontWeight.normal)),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: controller,
              decoration: InputDecoration(hintText: "contoh: tugas basis data"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL', style: TextStyle(fontFamily: 'Londrina Solid', fontWeight: FontWeight.normal)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK', style: TextStyle(fontFamily: 'Londrina Solid', fontWeight: FontWeight.normal, fontSize: 20)),
                onPressed: () {
                  setState(() {
                    String text = controller.text;
                    if (text == '') {
                      return;
                    } else {
                      codeDialog = valueText;
                      Navigator.pop(context);
                      todo.insert(0, controller.text);
                      values.insert(0, false);
                      controller.clear();
                    }
                  });
                },
              ),
            ],
          );
        });
  }
}
