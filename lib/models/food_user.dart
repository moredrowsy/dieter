import 'package:json_annotation/json_annotation.dart';

part 'food_user.g.dart';

@JsonSerializable()
class FoodUser {
  @JsonKey(defaultValue: "")
  String uid = "";

  @JsonKey(defaultValue: "")
  String username;

  @JsonKey(defaultValue: "")
  String email;

  @JsonKey(defaultValue: 0)
  double height; // in inches, in

  @JsonKey(defaultValue: 0)
  double weight; // in pounds, lbs

  @JsonKey(defaultValue: "male")
  String sex; // male or female

  @JsonKey(defaultValue: 0)
  int age;

  @JsonKey(defaultValue: 0)
  double bmi;

  @JsonKey(defaultValue: 0)
  double bmr;

  FoodUser(
      {this.uid = "",
      this.username = "",
      this.email = "",
      this.height = 0,
      this.weight = 0,
      this.sex = "",
      this.age = 0,
      this.bmi = 0,
      this.bmr = 0});

  factory FoodUser.fromJson(Map<String, dynamic> json) =>
      _$FoodUserFromJson(json);

  Map<String, dynamic> toJson() => _$FoodUserToJson(this);
}
