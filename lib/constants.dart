import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';

List<Food> defaultFoods = [
  // Soup
  Food(name: 'Minestrone Soup', calories: 203),
  Food(name: 'Cabbage Soup', calories: 170),
  Food(name: 'Bean and Vegetable Soup', calories: 174),

  // Fruits
  Food(name: 'Apple', calories: 95),
  Food(name: 'Banana', calories: 105),

// Bowls
  Food(name: 'Yoshinoya Original Beef Reg Bowl', calories: 425),
  Food(name: 'Yoshinoya Orange Chicken Reg Bowl', calories: 424),
  Food(name: 'Yoshinoya Grilled Teriyaki Chicken Reg Bowl', calories: 510),

  // Dishes
  Food(name: 'Oatmeal', calories: 158),
  Food(name: 'Egg Omelet', calories: 181),
  Food(name: 'Steak and Broccoli', calories: 338),
  Food(name: 'Salmon & Dill with Sweet Potato Mash', calories: 325),
  Food(name: 'Mushrooms and Ground Beef', calories: 314),
  Food(name: 'Halal Guys Small Chicken', calories: 356),
  Food(name: 'Halal Guys Small Beef Gyro', calories: 356),
  Food(name: 'Halal Guys Small Combo', calories: 357),

  // Burgers
  Food(name: 'Chick-fil-A Chicken Sandwich', calories: 440),
  Food(name: 'McDonald Quarter Pounder with Cheese', calories: 520),
  Food(name: 'McDonald Bacon, Egg, & Cheese', calories: 460),
  Food(name: 'In-N-Out Hamburger w/ Onion', calories: 243),
  Food(name: 'In-N-Out Double Double w/ Onion', calories: 330),

  // Sandiwches
  Food(name: 'Halal Guys Beef Gyro Sandwich', calories: 278),
  Food(name: 'Halal Guys Chicken Sandwich', calories: 278),
  Food(name: 'Halal Guys Falafel Sandwich', calories: 276),
  Food(name: 'Subway All-American CLub', calories: 350),
  Food(name: 'Subway BBQ Chicken', calories: 300),
  Food(name: 'Subway Black Forest Ham', calories: 270),
  Food(name: 'Subway Buffalo Chicken', calories: 340),
  Food(name: 'Subway Chicken Mango Curry', calories: 300),

  // Salad
  Food(name: 'Salad', calories: 20),

  // Drinks
  Food(name: 'Gatorade', calories: 1),
  Food(name: 'Milk', calories: 103),
  Food(name: 'Green Tea and Lemon', calories: 0),

  // Sides
  Food(name: 'Yogurt, Raspberries & Cream', calories: 110),
  Food(name: 'McDonald Fries', calories: 220),
];

Map<String, Food> defaultFoodsMap = {for (var e in defaultFoods) e.name: e};

FoodSchedule fs1 =
    FoodSchedule(name: 'Oatmeal, In-N-Out Burger, Beef Bowl', breakfast: [
  defaultFoodsMap['Oatmeal']!,
  defaultFoodsMap['Milk']!,
], lunch: [
  defaultFoodsMap['In-N-Out Hamburger w/ Onion']!,
  defaultFoodsMap['Gatorade']!,
], dinner: [
  defaultFoodsMap['Yoshinoya Original Beef Reg Bowl']!,
  defaultFoodsMap['Green Tea and Lemon']!,
]);
FoodSchedule fs2 = FoodSchedule(
    name: 'Minestrone Soup, Halal Guys Sandwich, Chicken Bowl',
    breakfast: [
      defaultFoodsMap['Minestrone Soup']!,
      defaultFoodsMap['Gatorade']!,
    ],
    lunch: [
      defaultFoodsMap['Halal Guys Beef Gyro Sandwich']!,
      defaultFoodsMap['Milk']!,
    ],
    dinner: [
      defaultFoodsMap['Yoshinoya Orange Chicken Reg Bowl']!,
      defaultFoodsMap['Green Tea and Lemon']!,
    ]);
FoodSchedule fs3 =
    FoodSchedule(name: 'Fruits, Chicken Sub, Chicken Bowl', breakfast: [
  defaultFoodsMap['Apple']!,
  defaultFoodsMap['Salad']!,
  defaultFoodsMap['Green Tea and Lemon']!,
], lunch: [
  defaultFoodsMap['Subway Buffalo Chicken']!,
  defaultFoodsMap['Gatorade']!,
], dinner: [
  defaultFoodsMap['Yoshinoya Grilled Teriyaki Chicken Reg Bowl']!,
  defaultFoodsMap['Milk']!,
]);
FoodSchedule fs4 = FoodSchedule(
    name: 'Veggie Soup, In-N-Out Burger, American Sub',
    breakfast: [
      defaultFoodsMap['Bean and Vegetable Soup']!,
      defaultFoodsMap['Green Tea and Lemon']!,
    ],
    lunch: [
      defaultFoodsMap['In-N-Out Hamburger w/ Onion']!,
      defaultFoodsMap['Gatorade']!,
    ],
    dinner: [
      defaultFoodsMap['Subway All-American CLub']!,
      defaultFoodsMap['Green Tea and Lemon']!,
    ]);
FoodSchedule fs5 = FoodSchedule(
    name: 'Salad, Halal Guys Combo, Steak and Broccoli',
    breakfast: [
      defaultFoodsMap['Salad']!,
      defaultFoodsMap['Milk']!,
    ],
    lunch: [
      defaultFoodsMap['Halal Guys Small Combo']!,
      defaultFoodsMap['Gatorade']!,
    ],
    dinner: [
      defaultFoodsMap['Steak and Broccoli']!,
      defaultFoodsMap['Green Tea and Lemon']!,
    ]);

List<FoodSchedule> defaultFoodSchedules = [fs1, fs2, fs3, fs4, fs5];
