import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_history.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/routes/food_schedule_page.dart';
import 'package:dieter/models/food_user.dart';
import 'package:dieter/routes/foods_page.dart';
import 'package:dieter/routes/history_page.dart';
import 'package:dieter/routes/login_page.dart';
import 'package:dieter/routes/profile_page.dart';
import 'package:dieter/routes/today_page.dart';
import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({
    Key? key,
    required this.title,
    required this.user,
    required this.setUser,
    required this.foods,
    required this.foodNames,
    required this.setFoods,
    required this.addFood,
    required this.removeFood,
    required this.foodSchedules,
    required this.foodscheduleNames,
    required this.setFoodSchedules,
    required this.addFoodScheduleItem,
    required this.deleteFoodScheduleItem,
    required this.updateFoodScheduleItem,
    required this.renameFoodScheduleName,
    required this.todayDate,
    required this.foodHistories,
    required this.setFoodHistories,
    required this.updateFoodHistory,
  }) : super(key: key);

  final String title;
  final FoodUser user;
  final Function setUser;
  final List<Food> foods;
  final Set<String> foodNames;
  final Function setFoods;
  final Function addFood;
  final Function removeFood;
  final List<FoodSchedule> foodSchedules;
  final Set<String> foodscheduleNames;
  final Function setFoodSchedules;
  final Function addFoodScheduleItem;
  final Function deleteFoodScheduleItem;
  final Function updateFoodScheduleItem;
  final Function renameFoodScheduleName;
  final DateTime todayDate;
  final Map<String, FoodHistory> foodHistories;
  final Function setFoodHistories;
  final Function updateFoodHistory;

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
        TodayPage(
            user: widget.user,
            todayDate: widget.todayDate,
            foodHistories: widget.foodHistories,
            updateFoodHistory: widget.updateFoodHistory),
        FoodSchedulePage(
          foods: widget.foods,
          foodscheduleNames: widget.foodscheduleNames,
          foodSchedules: widget.foodSchedules,
          addFoodScheduleItem: widget.addFoodScheduleItem,
          deleteFoodScheduleItem: widget.deleteFoodScheduleItem,
          updateFoodScheduleItem: widget.updateFoodScheduleItem,
          renameFoodScheduleName: widget.renameFoodScheduleName,
        ),
        FoodsPage(
          foods: widget.foods,
          foodNames: widget.foodNames,
          addFood: widget.addFood,
          removeFood: widget.removeFood,
        ),
        HistoryPage(user: widget.user, foodHistories: widget.foodHistories),
        ProfilePage(
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
              label: _widgetOptions[0].title,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.schedule),
              label: _widgetOptions[1].title,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.food_bank_rounded),
              label: _widgetOptions[2].title,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history),
              label: _widgetOptions[3].title,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: _widgetOptions[4].title,
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
          child: LoginPage(
            setUser: widget.setUser,
            setFoods: widget.setFoods,
            setFoodSchedules: widget.setFoodSchedules,
            setFoodHistories: widget.setFoodHistories,
          ),
        ),
      );
    }
  }
}
