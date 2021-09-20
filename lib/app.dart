import 'package:flutter/material.dart';
import 'routes/navigator.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dieter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigator(
        title: 'Dieter',
      ),
    );
  }
}
