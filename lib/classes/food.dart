class Food {
  Food({this.name = "", this.calories = 0});

  String name;
  int calories;

  Food.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        calories = int.parse(json['calories']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'calories': calories.toString(),
      };
}

class FoodItem extends Food {
  FoodItem({String name = "", int calories = 0, this.done = false})
      : super(name: name, calories: calories);
  bool done;

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    final food = Food.fromJson(json);

    return FoodItem(
        name: food.name,
        calories: food.calories,
        done: json['done'] == 'true' ? true : false);
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'done': done.toString()};
}
