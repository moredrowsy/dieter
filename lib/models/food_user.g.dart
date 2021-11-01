// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodUser _$FoodUserFromJson(Map<String, dynamic> json) => FoodUser(
      uid: json['uid'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      height: (json['height'] as num?)?.toDouble() ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
      sex: json['sex'] as String? ?? 'male',
      age: json['age'] as int? ?? 0,
      bmi: (json['bmi'] as num?)?.toDouble() ?? 0,
      bmr: (json['bmr'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$FoodUserToJson(FoodUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'email': instance.email,
      'height': instance.height,
      'weight': instance.weight,
      'sex': instance.sex,
      'age': instance.age,
      'bmi': instance.bmi,
      'bmr': instance.bmr,
    };
