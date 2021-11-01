import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  Food({this.name = "", this.calories = 0, this.done = false});

  @JsonKey(defaultValue: "")
  String name;

  @JsonKey(defaultValue: 0)
  int calories;

  @JsonKey(defaultValue: false)
  bool done;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
