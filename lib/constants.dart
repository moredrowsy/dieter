import 'package:dieter/models/food.dart';

List<Food> defaultFoods = [
  Food(name: "Beef Bowl", calories: 600),
  Food(name: "Hamburger", calories: 390),
  Food(name: "Gatorade", calories: 1),
  Food(name: "Milk", calories: 103),
  Food(name: "Oatmeal", calories: 158),
];

Map<String, Food> defaultFoodsMap = {for (var e in defaultFoods) e.name: e};
