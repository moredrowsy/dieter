import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key, required this.title}) : super(key: key);

  final String title;

  String getTitle() {
    return title;
  }

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
