import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key, this.title = ""}) : super(key: key);

  final String title;

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
