// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      name: json['name'] as String? ?? '',
      calories: json['calories'] as int? ?? 0,
      done: json['done'] as bool? ?? false,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'name': instance.name,
      'calories': instance.calories,
      'done': instance.done,
    };
