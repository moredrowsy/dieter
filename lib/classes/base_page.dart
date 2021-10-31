import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  BasePage({Key? key, this.title = ""}) : super(key: key);

  String title;

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
