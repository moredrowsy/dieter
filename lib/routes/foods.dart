import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';

class Foods extends BasePage {
  const Foods({Key? key}) : super(key: key, title: "Foods");

  @override
  BasePageState createState() => _FoodsState();
}

class _FoodsState extends BasePageState<Foods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[Text("Foods page")],
        ),
      ),
    );
  }
}
