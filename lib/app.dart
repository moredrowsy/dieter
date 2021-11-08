import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/models/food_history.dart';
import 'package:dieter/models/food_user.dart';
import 'package:dieter/routes/navigator.dart';
import 'package:dieter/utils/firebase.dart';
import 'package:dieter/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  FoodUser _user = FoodUser();
  List<Food> _foods = [];
  Set<String> _foodNames = {};
  List<FoodSchedule> _foodSchedules = [];
  Set<String> _foodscheduleNames = {};
  Map<String, FoodHistory> _foodHistories = {};
  final DateTime _todayDate = DateTime.now();

  void _setUser(FoodUser newUser, [bool fbSet = true]) {
    setState(() {
      String dateString = _todayDate.toString().substring(0, 10);
      if (_foodHistories.containsKey(dateString)) {
        _foodHistories[dateString]!.bmi = newUser.bmi;
        _foodHistories[dateString]!.bmr = newUser.bmr;
      }

      _user = FoodUser(
          uid: newUser.uid,
          username: newUser.username,
          email: newUser.email,
          height: newUser.height,
          weight: newUser.weight,
          sex: newUser.sex,
          age: newUser.age,
          bmi: newUser.bmi,
          bmr: newUser.bmr);

      if (!_user.isEmptyUser() && fbSet) {
        fbSetUser(_user);
        fbSetFoodHistory(_user.uid, _foodHistories[dateString]!);
      }
    });
  }

  void _setFoods(List<Food> foods, [bool fbSet = true]) {
    if (!_user.isEmptyUser() && fbSet) {
      fbSetFoods(_user.uid, foods);
    }

    setState(() {
      _foods = foods;
      for (var element in foods) {
        _foodNames.add(element.name);
      }
    });
  }

  void _addFood(Food food) {
    setState(() {
      if (_user.uid.isNotEmpty) fbSetFood(_user.uid, food);
      _foods = [..._foods, food];
      _foodNames.add(food.name);
    });
  }

  void _removeFood(int index) {
    setState(() {
      if (_user.uid.isNotEmpty) fbRemoveFood(_user.uid, _foods[index]);
      _foodNames.remove(_foods[index].name);
      _foods.removeAt(index);
      _foods = [..._foods];
    });
  }

  void _setFoodSchedules(List<FoodSchedule> foodSchedules,
      [bool fbSet = true]) {
    if (!_user.isEmptyUser() && fbSet) {
      fbSetFoodSchedules(_user.uid, foodSchedules);
    }

    setState(() {
      _foodSchedules = foodSchedules;
      for (var element in foodSchedules) {
        _foodscheduleNames.add(element.name);
      }
    });
  }

  void _addFoodScheduleItem(FoodSchedule foodSchedule) {
    setState(() {
      _foodSchedules.add(foodSchedule);
      _foodSchedules = [..._foodSchedules];
      _foodscheduleNames.add(foodSchedule.name);
      if (_user.uid.isNotEmpty) fbAddFoodSchedule(_user.uid, foodSchedule);
    });
  }

  void _deleteFoodScheduleItem(int index) {
    setState(() {
      if (_user.uid.isNotEmpty) {
        fbRemoveFoodSchedule(_user.uid, _foodSchedules[index].name);
      }
      _foodscheduleNames.remove(_foodSchedules[index].name);
      _foodSchedules.removeAt(index);
      _foodSchedules = [..._foodSchedules];
    });
  }

  void _setFoodHistory(FoodHistory foodHistory, [bool fbSet = true]) {
    if (!_user.isEmptyUser() && fbSet) {
      fbSetFoodHistory(_user.uid, foodHistory);
    }

    setState(() {
      _foodHistories[foodHistory.dateString] = foodHistory;
    });
  }

  void _setFoodHistories(Map<String, FoodHistory> foodHistories,
      [bool fbSet = true]) {
    if (!_user.isEmptyUser() && fbSet) {
      fbSetFoodHistories(_user.uid, foodHistories);
    }

    setState(() {
      _foodHistories = foodHistories;
    });
  }

  void _updateFoodScheduleItem(int index, FoodSchedule foodSchedule) {
    setState(() {
      _foodSchedules[index] = foodSchedule;
      _foodSchedules = [..._foodSchedules];
      if (_user.uid.isNotEmpty) fbAddFoodSchedule(_user.uid, foodSchedule);
    });
  }

  void _renameFoodScheduleName(
      int index, FoodSchedule foodSchedule, String oldName) {
    setState(() {
      if (_user.uid.isNotEmpty) fbRemoveFoodSchedule(_user.uid, oldName);
      _foodscheduleNames.remove(oldName);
      _foodSchedules[index] = foodSchedule;
      _foodSchedules = [..._foodSchedules];
      _foodscheduleNames.add(foodSchedule.name);
      if (_user.uid.isNotEmpty) fbAddFoodSchedule(_user.uid, foodSchedule);
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
      if (_user.uid.isNotEmpty) {
        fbSetFoodHistory(_user.uid, _foodHistories[dateKey]!);
      }
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
    if (_user.isEmptyUser()) {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          setState(() {
            _user = FoodUser();
            _foods = [];
            _foodNames = {};
            _foodSchedules = [];
            _foodscheduleNames = {};
            _foodHistories = {};
          });
        } else {
          fbHydrateApp(
              user, _setFoods, _setFoodSchedules, _setFoodHistories, _setUser);
        }
      });
    }

    if (_foodSchedules.isNotEmpty) {
      String dateString = _todayDate.toString().substring(0, 10);
      if (!_foodHistories.containsKey(dateString)) {
        FoodHistory fh = FoodHistory(
            dateString: dateString,
            dateTime: _todayDate,
            foodSchedule: _getNewRandomFoodSchedule(),
            bmr: _user.bmr,
            bmi: _user.bmi);
        _setFoodHistory(fh);
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dieter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigator(
        title: 'Dieter',
        user: _user,
        setUser: _setUser,
        foods: _foods,
        foodNames: _foodNames,
        setFoods: _setFoods,
        addFood: _addFood,
        removeFood: _removeFood,
        foodSchedules: _foodSchedules,
        foodscheduleNames: _foodscheduleNames,
        setFoodSchedules: _setFoodSchedules,
        addFoodScheduleItem: _addFoodScheduleItem,
        deleteFoodScheduleItem: _deleteFoodScheduleItem,
        updateFoodScheduleItem: _updateFoodScheduleItem,
        renameFoodScheduleName: _renameFoodScheduleName,
        todayDate: _todayDate,
        foodHistories: _foodHistories,
        setFoodHistories: _setFoodHistories,
        updateFoodHistory: _updateFoodHistory,
      ),
    );
  }
}
