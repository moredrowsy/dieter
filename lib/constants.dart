import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';

List<Food> defaultFoods = [
  Food(name: "Beef Bowl", calories: 600),
  Food(name: "Hamburger", calories: 390),
  Food(name: "Gatorade", calories: 1),
  Food(name: "Milk", calories: 103),
  Food(name: "Oatmeal", calories: 158),
];

Map<String, Food> defaultFoodsMap = {for (var e in defaultFoods) e.name: e};

FoodSchedule fs1 = FoodSchedule(
    name: 'Oatmeal, Burger, Beef Bowl',
    breakfast: [defaultFoodsMap["Oatmeal"]!, defaultFoodsMap["Milk"]!],
    lunch: [defaultFoodsMap["Hamburger"]!, defaultFoodsMap["Gatorade"]!],
    dinner: [defaultFoodsMap["Beef Bowl"]!]);
FoodSchedule fs2 = FoodSchedule(
    name: 'Oatmeal, Burger, Beef Bowl',
    breakfast: [defaultFoodsMap["Hamburger"]!, defaultFoodsMap["Gatorade"]!],
    lunch: [defaultFoodsMap["Oatmeal"]!, defaultFoodsMap["Milk"]!],
    dinner: [defaultFoodsMap["Beef Bowl"]!]);

List<FoodSchedule> defaultFoodSchedules = [fs1, fs2];
