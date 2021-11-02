import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_history.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/models/food_user.dart';
import 'package:flutter/material.dart';

class TodayPage extends BasePage {
  const TodayPage({
    Key? key,
    required this.user,
    required this.todayDate,
    required this.foodHistories,
    required this.updateFoodHistory,
  }) : super(key: key, title: "Today");

  final FoodUser user;
  final Map<String, FoodHistory> foodHistories;
  final DateTime todayDate;
  final Function updateFoodHistory;

  @override
  BasePageState createState() => _TodayPageState();
}

class _TodayPageState extends BasePageState<TodayPage> {
  FoodSchedule todayFoodSchedule = FoodSchedule(name: "", totalCalories: 0);
  double bmr = 0;

  void toggleFoodItem(String listType, int index, Food food) {
    food.done = !food.done;
    widget.updateFoodHistory(
      widget.todayDate.toString().substring(0, 10),
      listType,
      index,
      food,
    );
  }

  @override
  Widget build(BuildContext context) {
    String todayDateString = widget.todayDate.toString().substring(0, 10);
    if (widget.foodHistories.containsKey(todayDateString)) {
      todayFoodSchedule = widget.foodHistories[todayDateString]!.foodSchedule;
      bmr = widget.foodHistories[todayDateString]!.bmr;
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Calories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                        '${todayFoodSchedule.currentCalories.toString()} / ${todayFoodSchedule.totalCalories.toString()}',
                        style: const TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'BMR',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(bmr.round().toString(),
                        style: const TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Breakfast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todayFoodSchedule.breakfast.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              todayFoodSchedule.breakfast[index].calories
                                  .toString(),
                              style: TextStyle(
                                decoration:
                                    todayFoodSchedule.breakfast[index].done
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                fontStyle: FontStyle.italic,
                                color: todayFoodSchedule.breakfast[index].done
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              todayFoodSchedule.breakfast[index].name,
                              style: TextStyle(
                                decoration:
                                    todayFoodSchedule.breakfast[index].done
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                color: todayFoodSchedule.breakfast[index].done
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                                todayFoodSchedule.breakfast[index].done
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 18),
                            color: todayFoodSchedule.breakfast[index].done
                                ? Colors.grey
                                : Colors.black,
                            tooltip: 'Toggle Food Item',
                            padding: EdgeInsets.zero,
                            onPressed: () => toggleFoodItem("breakfast", index,
                                todayFoodSchedule.breakfast[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Text(
            'Lunch',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todayFoodSchedule.lunch.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              todayFoodSchedule.lunch[index].calories
                                  .toString(),
                              style: TextStyle(
                                decoration: todayFoodSchedule.lunch[index].done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontStyle: FontStyle.italic,
                                color: todayFoodSchedule.lunch[index].done
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              todayFoodSchedule.lunch[index].name,
                              style: TextStyle(
                                decoration: todayFoodSchedule.lunch[index].done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: todayFoodSchedule.lunch[index].done
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                                todayFoodSchedule.lunch[index].done
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 18),
                            color: todayFoodSchedule.lunch[index].done
                                ? Colors.grey
                                : Colors.black,
                            tooltip: 'Toggle Food Item',
                            padding: EdgeInsets.zero,
                            onPressed: () => toggleFoodItem(
                                "lunch", index, todayFoodSchedule.lunch[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Text(
            'Dinner',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todayFoodSchedule.dinner.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              todayFoodSchedule.dinner[index].calories
                                  .toString(),
                              style: TextStyle(
                                decoration: todayFoodSchedule.dinner[index].done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontStyle: FontStyle.italic,
                                color: todayFoodSchedule.dinner[index].done
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              todayFoodSchedule.dinner[index].name,
                              style: TextStyle(
                                decoration: todayFoodSchedule.dinner[index].done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: todayFoodSchedule.dinner[index].done
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                                todayFoodSchedule.dinner[index].done
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 18),
                            color: todayFoodSchedule.dinner[index].done
                                ? Colors.grey
                                : Colors.black,
                            tooltip: 'Toggle Food Item',
                            padding: EdgeInsets.zero,
                            onPressed: () => toggleFoodItem("dinner", index,
                                todayFoodSchedule.dinner[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
