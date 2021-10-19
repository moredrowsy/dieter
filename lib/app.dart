import 'package:flutter/material.dart';
import 'package:dieter/classes/user.dart';
import 'package:dieter/routes/navigator.dart';
import 'package:dieter/classes/food.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  User user = User();
  List<Food> _foods = [
    Food(name: "Beef Bowl", calories: 600),
    Food(name: "Hamburger", calories: 390),
    Food(name: "Gatorade", calories: 1),
    Food(name: "Milk", calories: 103),
    Food(name: "Oatmeal", calories: 158),
  ];

  void _setUser(User newUser) {
    setState(() {
      user = newUser;
    });
  }

  void _addFood(Food food) {
    setState(() {
      _foods = [..._foods, food];
    });
  }

  void _removeFood(int index) {
    setState(() {
      _foods.removeAt(index);
      _foods = [..._foods];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dieter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigator(
        title: 'Dieter',
        user: user,
        setUser: _setUser,
        foods: _foods,
        addFood: _addFood,
        removeFood: _removeFood,
      ),
    );
  }
}
