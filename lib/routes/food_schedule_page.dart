import 'package:dieter/routes/food_schedule_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';

class FoodSchedulePage extends BasePage {
  FoodSchedulePage({
    Key? key,
    required this.foods,
    required this.foodSchedules,
    required this.addFoodScheduleItem,
    required this.deleteFoodScheduleItem,
    required this.updateFoodScheduleItem,
  }) : super(key: key, title: "Food Schedule");

  final List<Food> foods;
  final List<FoodSchedule> foodSchedules;
  final Function addFoodScheduleItem;
  final Function deleteFoodScheduleItem;
  final Function updateFoodScheduleItem;

  @override
  BasePageState createState() => _FoodSchedulePageState();
}

class _FoodSchedulePageState extends BasePageState<FoodSchedulePage> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  final newFoodScheduleNameController = TextEditingController();
  int foodScheduleIndex = 0;

  void gotoFoodScheduleEdit(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodScheduleEditPage(
          foods: widget.foods,
          foodSchedules: widget.foodSchedules,
          foodScheduleIndex: index,
          updateFoodScheduleItem: widget.updateFoodScheduleItem,
        ),
      ),
    );
  }

  void addFoodSchedule() {
    if (newFoodScheduleNameController.text.isNotEmpty) {
      widget.addFoodScheduleItem(
          FoodSchedule(name: newFoodScheduleNameController.text));
      newFoodScheduleNameController.text = "";
    }
  }

  void deleteFoodSchedule(int index) {
    widget.deleteFoodScheduleItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10, left: 5, right: 0),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    autofocus: false,
                    controller: newFoodScheduleNameController,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(9),
                      border: OutlineInputBorder(),
                      labelText: 'New Food Schedule Name',
                    ),
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    tooltip: 'Add Food Schedule',
                    padding: EdgeInsets.zero,
                    onPressed: addFoodSchedule,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.foodSchedules.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 50,
                    // child: Center(child: Text('Entry ${dinner[index]['name']}')),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 20, left: 10, right: 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              '${widget.foodSchedules[index].totalCalories}',
                            )),
                          ),
                          Expanded(
                            flex: 8,
                            child: Center(
                                child: Text(
                              widget.foodSchedules[index].name,
                            )),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.edit, size: 18),
                              tooltip: 'Edit Food Schedule',
                              padding: EdgeInsets.zero,
                              onPressed: () => gotoFoodScheduleEdit(index),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              tooltip: 'Remove Food Schedule',
                              padding: EdgeInsets.zero,
                              onPressed: () => deleteFoodSchedule(index),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
