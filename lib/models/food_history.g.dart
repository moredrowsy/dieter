// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodHistory _$FoodHistoryFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['dateString', 'dateTime', 'foodSchedule'],
  );
  return FoodHistory(
    dateString: json['dateString'] as String,
    dateTime: DateTime.parse(json['dateTime'] as String),
    foodSchedule:
        FoodSchedule.fromJson(json['foodSchedule'] as Map<String, dynamic>),
    bmi: (json['bmi'] as num?)?.toDouble() ?? 0,
    bmr: (json['bmr'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$FoodHistoryToJson(FoodHistory instance) =>
    <String, dynamic>{
      'dateString': instance.dateString,
      'dateTime': instance.dateTime.toIso8601String(),
      'foodSchedule': instance.foodSchedule,
      'bmi': instance.bmi,
      'bmr': instance.bmr,
    };
