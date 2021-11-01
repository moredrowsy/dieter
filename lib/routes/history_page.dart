import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/models/food_user.dart';

class HistoryPage extends BasePage {
  const HistoryPage({
    Key? key,
    required this.user,
    required this.foodHistory,
  }) : super(key: key, title: "History");

  final FoodUser user;
  final Map<String, FoodSchedule> foodHistory;

  @override
  BasePageState createState() => _HistoryPageState();
}

class _HistoryPageState extends BasePageState<HistoryPage> {
  FoodSchedule todayFoodSchedule = FoodSchedule(name: "", totalCalories: 0);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> foodHistoryList = [
      for (var e in widget.foodHistory.entries) {"date": e.key, "food": e.value}
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 18,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 52,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: const Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'Calories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foodHistoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 0, left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 18,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              foodHistoryList[index]["date"],
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 52,
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              foodHistoryList[index]["food"].name.toString(),
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${foodHistoryList[index]["food"].currentCalories} / ${foodHistoryList[index]["food"].totalCalories}',
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                              ),
                            ),
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
      ),
    );
  }
}
