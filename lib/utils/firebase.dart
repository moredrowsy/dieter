import 'dart:convert';

import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_history.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/models/food_user.dart';
import 'package:firebase_database/firebase_database.dart';

void fbHydrateFoods(String uid, Function callback) {
  FirebaseDatabase.instance
      .reference()
      .child('foods/' + uid)
      .once()
      .then((docSnapshot) {
    List<Food> foods = [];
    docSnapshot.value.forEach((k, v) {
      foods.add(Food.fromJson(jsonDecode(v)));
    });
    callback(foods);
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbfbHydrateFoodschedules(String uid, Function callback) {
  FirebaseDatabase.instance
      .reference()
      .child('foodSchedules/' + uid)
      .once()
      .then((docSnapshot) {
    List<FoodSchedule> foodSchedules = [];
    docSnapshot.value.forEach((k, v) {
      foodSchedules.add(FoodSchedule.fromJson(jsonDecode(v)));
    });
    callback(foodSchedules);
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbHydrateFoodHistories(String uid, Function callback) {
  FirebaseDatabase.instance
      .reference()
      .child('foodHistories/' + uid)
      .once()
      .then((docSnapshot) {
    Map<String, FoodHistory> foodHistories = {};
    docSnapshot.value.cast<String, dynamic>().forEach((k, v) {
      FoodHistory fh =
          FoodHistory.fromJson(jsonDecode(v).cast<String, dynamic>());
      foodHistories[fh.dateString] = fh;
    });
    callback(foodHistories);
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbHydrateUser(String uid, Function callback) {
  FirebaseDatabase.instance
      .reference()
      .child('users/' + uid)
      .once()
      .then((docSnapshot) {
    FoodUser user =
        FoodUser.fromJson(docSnapshot.value.cast<String, dynamic>());

    callback(user);
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbSetFoods(String uid, List<Food> foods, [Function? callback]) {
  Map<String, String> foodsEncoded = {
    for (var e in foods) e.name: jsonEncode(e)
  };
  FirebaseDatabase.instance
      .reference()
      .child('foods/' + uid)
      .set(foodsEncoded)
      .then((value) {
    callback!(foodsEncoded);
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbSetFood(String uid, Food food, [Function? callback]) {
  FirebaseDatabase.instance
      .reference()
      .child('foods/' + uid + '/' + food.name)
      .set(jsonEncode(food))
      .then((value) {
    callback!();
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbRemoveFood(String uid, Food food, [Function? callback]) {
  FirebaseDatabase.instance
      .reference()
      .child('foods/' + uid + '/' + food.name)
      .remove()
      .then((value) {
    callback!();
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbSetFoodSchedules(String uid, List<FoodSchedule> foodSchedules,
    [Function? callback]) {
  Map<String, String> foodSchdulesEncoded = {
    for (int i = 0; i < foodSchedules.length; ++i)
      foodSchedules[i].name: jsonEncode(foodSchedules[i])
  };
  FirebaseDatabase.instance
      .reference()
      .child('foodSchedules/' + uid)
      .set(foodSchdulesEncoded)
      .then((value) {
    callback!(foodSchdulesEncoded);
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbAddFoodSchedule(String uid, FoodSchedule foodSchdule,
    [Function? callback]) {
  FirebaseDatabase.instance
      .reference()
      .child('foodSchedules/' + uid + '/' + foodSchdule.name)
      .set(jsonEncode(foodSchdule))
      .then((value) {
    callback!();
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbRemoveFoodSchedule(String uid, String key, [Function? callback]) {
  FirebaseDatabase.instance
      .reference()
      .child('foodSchedules/' + uid + '/' + key)
      .remove()
      .then((value) {
    callback!();
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbSetFoodHistories(String uid, Map<String, FoodHistory> foodHistories,
    [Function? callback]) {
  Map<String, String> foodHistoriesEncoded =
      foodHistories.map((key, value) => MapEntry(key, jsonEncode(value)));
  FirebaseDatabase.instance
      .reference()
      .child('foodHistories/' + uid)
      .set(foodHistoriesEncoded)
      .then((value) {
    callback!(foodHistoriesEncoded);
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbSetFoodHistory(String uid, FoodHistory foodHistory,
    [Function? callback]) {
  FirebaseDatabase.instance
      .reference()
      .child('foodHistories/' + uid + '/' + foodHistory.dateString)
      .set(jsonEncode(foodHistory))
      .then((value) {
    callback!();
  }).catchError((error) {
    // print(error.toString());
  });
}

void fbSetUser(FoodUser user, [Function? callback]) {
  FirebaseDatabase.instance
      .reference()
      .child('users/' + user.uid)
      .set({...user.toJson()}).then((value) {
    callback!(user);
  }).catchError((error) {
    // print(error.toString());
  });
}
