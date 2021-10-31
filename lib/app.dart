import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dieter/constants.dart';
import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/models/user.dart';
import 'package:dieter/routes/navigator.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  User user = User();
  List<Food> _foods = [...defaultFoods];
  List<FoodSchedule> _foodSchedules = [];
  Map<String, FoodSchedule> _foodHistory = {};
  DateTime _todayDate = DateTime.now();

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
      _foodHistory[dateKey]!.updateCurrentCalories();
      _foodHistory = {..._foodHistory};
    });
  }

  FoodSchedule _getNewRandomFoodSchedule() {
    if (_foodSchedules.isNotEmpty) {
      FoodSchedule randFS =
          _foodSchedules[Random().nextInt(_foodSchedules.length)];
      FoodSchedule newFoodSchedule =
          FoodSchedule(name: randFS.name, totalCalories: randFS.totalCalories);

      for (Food food in randFS.breakfast) {
        newFoodSchedule.breakfast.add(Food(
          name: food.name,
          calories: food.calories,
        ));
      }
      for (Food food in randFS.lunch) {
        newFoodSchedule.lunch.add(Food(
          name: food.name,
          calories: food.calories,
        ));
      }
      for (Food food in randFS.dinner) {
        newFoodSchedule.dinner.add(Food(
          name: food.name,
          calories: food.calories,
        ));
      }

      return newFoodSchedule;
    } else {
      return FoodSchedule(name: "Default");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_foodSchedules.isEmpty) {
      // Add default food schedule
      _foodSchedules.add(FoodSchedule(name: "Oatmeal, Burger, Beef Bowl"));
      _foodSchedules[0].addBreakfast(Food(
          name: defaultFoodsMap["Oatmeal"]!.name,
          calories: defaultFoodsMap["Oatmeal"]!.calories));
      _foodSchedules[0].addBreakfast(Food(
          name: defaultFoodsMap["Milk"]!.name,
          calories: defaultFoodsMap["Milk"]!.calories));
      _foodSchedules[0].addLunch(Food(
          name: defaultFoodsMap["Hamburger"]!.name,
          calories: defaultFoodsMap["Hamburger"]!.calories));
      _foodSchedules[0].addLunch(Food(
          name: defaultFoodsMap["Gatorade"]!.name,
          calories: defaultFoodsMap["Gatorade"]!.calories));
      _foodSchedules[0].addDinner(Food(
          name: defaultFoodsMap["Beef Bowl"]!.name,
          calories: defaultFoodsMap["Beef Bowl"]!.calories));
    }

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
        user: user,
        setUser: _setUser,
        foods: _foods,
        addFood: _addFood,
        removeFood: _removeFood,
        foodSchedules: _foodSchedules,
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
