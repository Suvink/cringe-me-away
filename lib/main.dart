import 'package:flutter/material.dart';
import "homepage.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              title: const Text('Cringe Me Away'),
            ),
            body: new Center(
              child: new SafeArea(child: HomePage()),
            )));
  }
}
