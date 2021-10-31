import 'package:dieter/models/food.dart';
import 'dart:convert';

class FoodSchedule {
  FoodSchedule({
    this.name = "",
    this.totalCalories = 0,
    this.currentCalories = 0,
  });

  String name;
  int totalCalories;
  int currentCalories;
  List<Food> breakfast = [];
  List<Food> lunch = [];
  List<Food> dinner = [];

  void addBreakfast(Food food) {
    breakfast.add(food);
    totalCalories += food.calories;
  }

  void addLunch(Food food) {
    lunch.add(food);
    totalCalories += food.calories;
  }

  void addDinner(Food food) {
    dinner.add(food);
    totalCalories += food.calories;
  }

  bool removeBreakfast(int index) {
    if (breakfast.length > index) {
      totalCalories -= breakfast[index].calories;
      breakfast.removeAt(index);
      return true;
    } else {
      return false;
    }
  }

  bool removeLunch(int index) {
    if (lunch.length > index) {
      totalCalories -= lunch[index].calories;
      lunch.removeAt(index);
      return true;
    } else {
      return false;
    }
  }

  bool removeDinner(int index) {
    if (dinner.length > index) {
      totalCalories -= dinner[index].calories;
      dinner.removeAt(index);
      return true;
    } else {
      return false;
    }
  }

  void updateCurrentCalories() {
    int calories = 0;
    for (Food food in breakfast) {
      if (food.done) {
        calories += food.calories;
      }
    }
    for (Food food in lunch) {
      if (food.done) {
        calories += food.calories;
      }
    }
    for (Food food in dinner) {
      if (food.done) {
        calories += food.calories;
      }
    }
    currentCalories = calories;
  }

  FoodSchedule.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        totalCalories = int.parse(json['totalCalories']),
        currentCalories = int.parse(json['currentCalories']),
        breakfast = jsonDecode(json['breakfast']),
        lunch = jsonDecode(json['lunch']),
        dinner = jsonDecode(json['dinner']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'totalCalories': totalCalories.toString(),
        'currentCalories': currentCalories.toString(),
        'breakfast': jsonEncode(breakfast),
        'lunch': jsonEncode(lunch),
        'dinner': jsonEncode(dinner),
      };
}
