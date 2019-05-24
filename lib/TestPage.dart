import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  String title;

  TestPage( {String title = 'hello'}) : super() {
    this.title = title;
  }

  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.title),
    );
  }
}
