import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/models/food_history.dart';
import 'package:dieter/models/food_user.dart';
import 'package:dieter/routes/navigator.dart';
import 'package:dieter/utils/helpers.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  FoodUser _user = FoodUser();
  List<Food> _foods = [];
  List<FoodSchedule> _foodSchedules = [];
  Map<String, FoodHistory> _foodHistories = {};
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

  void _setFoodHistories(Map<String, FoodHistory> foodHistories) {
    setState(() {
      _foodHistories = foodHistories;
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
        _foodHistories[dateKey]!.foodSchedule.breakfast[index] = food;
      } else if (listType == "lunch") {
        _foodHistories[dateKey]!.foodSchedule.lunch[index] = food;
      } else if (listType == "dinner") {
        _foodHistories[dateKey]!.foodSchedule.dinner[index] = food;
      }
      _foodHistories[dateKey]!.foodSchedule.updateCalories();
      _foodHistories = {..._foodHistories};
    });
  }

  FoodSchedule _getNewRandomFoodSchedule() {
    if (_foodSchedules.isNotEmpty) {
      return getNewRandomFoodSchedule(_foodSchedules);
    } else {
      return FoodSchedule(name: "Default");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_foodHistories.isEmpty) {
      if (_foodSchedules.isNotEmpty) {
        String dateString = _todayDate.toString().substring(0, 10);
        if (!_foodHistories.containsKey(dateString)) {
          setState(() {
            _foodHistories[dateString] = FoodHistory(
                dateString: dateString,
                dateTime: _todayDate,
                foodSchedule: _getNewRandomFoodSchedule(),
                bmr: _user.bmr,
                bmi: _user.bmi);
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
        foodHistories: _foodHistories,
        setFoodHistories: _setFoodHistories,
        updateFoodHistory: _updateFoodHistory,
      ),
    );
  }
}
