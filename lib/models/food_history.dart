import 'package:dieter/models/food_schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_history.g.dart';

@JsonSerializable()
class FoodHistory {
  FoodHistory({
    required this.dateString,
    required this.dateTime,
    required this.foodSchedule,
    this.bmi = 0,
    this.bmr = 0,
  });

  @JsonKey(required: true)
  String dateString;

  @JsonKey(required: true)
  DateTime dateTime;

  @JsonKey(required: true)
  FoodSchedule foodSchedule;

  @JsonKey(defaultValue: 0)
  double bmi;

  @JsonKey(defaultValue: 0)
  double bmr;

  factory FoodHistory.fromJson(Map<String, dynamic> json) =>
      _$FoodHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$FoodHistoryToJson(this);
}
