import 'package:dieter/utils/helpers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_user.g.dart';

@JsonSerializable()
class FoodUser {
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

  bool isEmptyUser() {
    return uid.isEmpty;
  }

  void updateBMIAndBMR() {
    // Calculate BMI
    // https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_1.html
    bmi = getBMI(
      height,
      weight,
    ).round().toDouble();

    // Calculate BMR
    // https://www.livestrong.com/article/382462-what-is-bmi-and-bmr/
    bmr = getBMR(height, weight, age, sex).round().toDouble();
  }

  factory FoodUser.fromJson(Map<String, dynamic> json) =>
      _$FoodUserFromJson(json);

  Map<String, dynamic> toJson() => _$FoodUserToJson(this);
}
