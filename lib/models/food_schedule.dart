import 'package:json_annotation/json_annotation.dart';
import 'package:dieter/models/food.dart';

part 'food_schedule.g.dart';

@JsonSerializable()
class FoodSchedule {
  FoodSchedule({
    this.name = "",
    this.totalCalories = 0,
    this.currentCalories = 0,
    List<Food>? breakfast,
    List<Food>? lunch,
    List<Food>? dinner,
  }) {
    this.breakfast = breakfast ?? [];
    this.lunch = lunch ?? [];
    this.dinner = dinner ?? [];
    updateCalories();
  }

  @JsonKey(defaultValue: "")
  String name;

  @JsonKey(defaultValue: 0)
  int totalCalories;

  @JsonKey(defaultValue: 0)
  int currentCalories;

  @JsonKey(defaultValue: [])
  List<Food> breakfast = [];

  @JsonKey(defaultValue: [])
  List<Food> lunch = [];

  @JsonKey(defaultValue: [])
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

  void updateTotalCalories() {
    int calories = 0;
    for (Food food in breakfast) {
      calories += food.calories;
    }
    for (Food food in lunch) {
      calories += food.calories;
    }
    for (Food food in dinner) {
      calories += food.calories;
    }
    totalCalories = calories;
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

  void updateCalories() {
    int currentCals = 0;
    int totalCals = 0;

    for (Food food in breakfast) {
      if (food.done) {
        currentCals += food.calories;
      }
      totalCals += food.calories;
    }
    for (Food food in lunch) {
      if (food.done) {
        currentCals += food.calories;
      }
      totalCals += food.calories;
    }
    for (Food food in dinner) {
      if (food.done) {
        currentCals += food.calories;
      }
      totalCals += food.calories;
    }
    currentCalories = currentCals;
    totalCalories = totalCals;
  }

  factory FoodSchedule.fromJson(Map<String, dynamic> json) =>
      _$FoodScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$FoodScheduleToJson(this);
}
