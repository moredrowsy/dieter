class Food {
  Food({this.name = "", this.calories = 0});

  String name;
  int calories;
}

class FoodItem extends Food {
  FoodItem({String name = "", int calories = 0, this.done = false})
      : super(name: name, calories: calories);
  bool done;
}
