import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/models/food_user.dart';
import 'package:dieter/routes/navigator.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  FoodUser _user = FoodUser();
  List<Food> _foods = [];
  List<FoodSchedule> _foodSchedules = [];
  Map<String, FoodSchedule> _foodHistory = {};
  final DateTime _todayDate = DateTime.now();

  void _setUser(FoodUser newUser) {
    setState(() {
      _user = newUser;
    });
  }

  void _setFoods(List<Food> foods) {
    setState(() {
      _foods = foods;
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

  void _setFoodSchedules(List<FoodSchedule> foodSchedules) {
    setState(() {
      _foodSchedules = foodSchedules;
    });
  }

  void _addFoodScheduleItem(FoodSchedule foodSchedule) {
    setState(() {
      _foodSchedules.add(foodSchedule);
      _foodSchedules = [..._foodSchedules];
    });
  }

  void _deleteFoodScheduleItem(int index) {
    setState(() {
      _foodSchedules.removeAt(index);
      _foodSchedules = [..._foodSchedules];
    });
  }

  void _updateFoodScheduleItem(int index, FoodSchedule foodSchedule) {
    setState(() {
      _foodSchedules[index] = foodSchedule;
      _foodSchedules = [..._foodSchedules];
    });
  }

  void _updateFoodHistory(
      String dateKey, String listType, int index, Food food) {
    setState(() {
      if (listType == "breakfast") {
        _foodHistory[dateKey]!.breakfast[index] = food;
      } else if (listType == "lunch") {
        _foodHistory[dateKey]!.lunch[index] = food;
      } else if (listType == "dinner") {
        _foodHistory[dateKey]!.dinner[index] = food;
      }
      _foodHistory[dateKey]!.updateCalories();
      _foodHistory = {..._foodHistory};
    });
  }

  FoodSchedule _getNewRandomFoodSchedule() {
    if (_foodSchedules.isNotEmpty) {
      FoodSchedule randFS =
          _foodSchedules[Random().nextInt(_foodSchedules.length)];
      FoodSchedule newFoodSchedule = FoodSchedule(
          name: randFS.name,
          currentCalories: randFS.currentCalories,
          totalCalories: randFS.totalCalories);

      for (Food food in randFS.breakfast) {
        newFoodSchedule.breakfast.add(Food(
          name: food.name,
          calories: food.calories,
          done: food.done,
        ));
      }
      for (Food food in randFS.lunch) {
        newFoodSchedule.lunch.add(Food(
          name: food.name,
          calories: food.calories,
          done: food.done,
        ));
      }
      for (Food food in randFS.dinner) {
        newFoodSchedule.dinner.add(Food(
          name: food.name,
          calories: food.calories,
          done: food.done,
        ));
      }

      newFoodSchedule.updateCalories();

      return newFoodSchedule;
    } else {
      return FoodSchedule(name: "Default");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_foodHistory.isEmpty) {
      if (_foodSchedules.isNotEmpty) {
        String date = _todayDate.toString().substring(0, 10);
        if (!_foodHistory.containsKey(date)) {
          setState(() {
            _foodHistory[date] = _getNewRandomFoodSchedule();
          });
        }
      }
    }

    return MaterialApp(
      title: 'Dieter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigator(
        title: 'Dieter',
        user: _user,
        setUser: _setUser,
        foods: _foods,
        setFoods: _setFoods,
        addFood: _addFood,
        removeFood: _removeFood,
        foodSchedules: _foodSchedules,
        setFoodSchedules: _setFoodSchedules,
        addFoodScheduleItem: _addFoodScheduleItem,
        deleteFoodScheduleItem: _deleteFoodScheduleItem,
        updateFoodScheduleItem: _updateFoodScheduleItem,
        todayDate: _todayDate,
        foodHistory: _foodHistory,
        updateFoodHistory: _updateFoodHistory,
      ),
    );
  }
}
