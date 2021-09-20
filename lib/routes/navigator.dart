import 'package:flutter/material.dart';
import 'package:dieter/routes/home.dart';
import 'package:dieter/routes/schedule.dart';
import 'package:dieter/routes/profile.dart';

/// This is the stateful widget that the main application instantiates.
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

/// This is the private State class that goes with BottomNavigator.
class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(title: 'Home'),
    const Schedule(title: 'Diet List'),
    const Profile(title: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_rounded),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
