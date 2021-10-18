import 'package:dieter/routes/foods.dart';
import 'package:dieter/routes/login.dart';
import 'package:flutter/material.dart';
import 'package:dieter/classes/user.dart';
import 'package:dieter/routes/today.dart';
import 'package:dieter/routes/schedule.dart';
import 'package:dieter/routes/profile.dart';

/// This is the stateful widget that the main application instantiates.
class BottomNavigator extends StatefulWidget {
  const BottomNavigator(
      {Key? key,
      required this.title,
      required this.user,
      required this.setUser})
      : super(key: key);

  final String title;
  final User user;
  final Function setUser;

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

/// This is the private State class that goes with BottomNavigator.
class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.username != "") {
      final List _widgetOptions = [
        Home(user: widget.user),
        const Schedule(),
        const Foods(),
        Profile(
          user: widget.user,
          setUser: widget.setUser,
        ),
      ];

      return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.today),
              label: _widgetOptions[0].getTitle(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.schedule),
              label: _widgetOptions[1].getTitle(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.food_bank_rounded),
              label: _widgetOptions[2].getTitle(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: _widgetOptions[3].getTitle(),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Login(
            setUser: widget.setUser,
          ),
        ),
      );
    }
  }
}
