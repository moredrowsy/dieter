import 'dart:math';

import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';

double getBMI(double height, double weight) {
  // Calculate BMI
  // https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_1.html
  double bmi = weight * 0.453592 / pow(height * 0.0254, 2);
  return bmi;
}

double getBMR(double height, double weight, int age, String sex) {
  // Calculate BMR
  // https://www.livestrong.com/article/382462-what-is-bmi-and-bmr/
  double bmr = 0;
  if (sex == "male") {
    bmr = 66 + (6.23 * weight) + (12.7 * height) - (6.8 * age);
  } else {
    bmr = 655 + (4.35 * weight) + (4.7 * height) - (4.7 * age);
  }

  return bmr;
}

FoodSchedule getNewRandomFoodSchedule(List<FoodSchedule> foodSchedules) {
  FoodSchedule randFS = foodSchedules[Random().nextInt(foodSchedules.length)];
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
}
