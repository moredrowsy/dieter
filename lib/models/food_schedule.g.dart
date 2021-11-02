// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodSchedule _$FoodScheduleFromJson(Map<String, dynamic> json) => FoodSchedule(
      name: json['name'] as String? ?? '',
      totalCalories: json['totalCalories'] as int? ?? 0,
      currentCalories: json['currentCalories'] as int? ?? 0,
      breakfast: (json['breakfast'] as List<dynamic>?)
              ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lunch: (json['lunch'] as List<dynamic>?)
              ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      dinner: (json['dinner'] as List<dynamic>?)
              ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FoodScheduleToJson(FoodSchedule instance) =>
    <String, dynamic>{
      'name': instance.name,
      'totalCalories': instance.totalCalories,
      'currentCalories': instance.currentCalories,
      'breakfast': instance.breakfast,
      'lunch': instance.lunch,
      'dinner': instance.dinner,
    };
