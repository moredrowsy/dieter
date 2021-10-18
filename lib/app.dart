import 'package:flutter/material.dart';
import 'package:dieter/classes/user.dart';
import 'package:dieter/routes/navigator.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  User user = User("", "", "", "", "", "", "", "");

  void _setUser(User newUser) {
    setState(() {
      user = newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dieter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigator(title: 'Dieter', user: user, setUser: _setUser),
    );
  }
}
