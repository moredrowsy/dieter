import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';
import 'package:dieter/routes/food_schedule_edit_page.dart';
import 'package:flutter/material.dart';

class FoodSchedulePage extends BasePage {
  const FoodSchedulePage({
    Key? key,
    required this.foods,
    required this.foodSchedules,
    required this.foodscheduleNames,
    required this.addFoodScheduleItem,
    required this.deleteFoodScheduleItem,
    required this.updateFoodScheduleItem,
    required this.renameFoodScheduleName,
  }) : super(key: key, title: "Food Schedule");

  final List<Food> foods;
  final List<FoodSchedule> foodSchedules;
  final Set<String> foodscheduleNames;
  final Function addFoodScheduleItem;
  final Function deleteFoodScheduleItem;
  final Function updateFoodScheduleItem;
  final Function renameFoodScheduleName;

  @override
  BasePageState createState() => _FoodSchedulePageState();
}

class _FoodSchedulePageState extends BasePageState<FoodSchedulePage> {
  String errorString = "";
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
          renameFoodScheduleName: widget.renameFoodScheduleName,
        ),
      ),
    );
  }

  void addFoodSchedule() {
    if (errorString.isEmpty) {
      widget.addFoodScheduleItem(
          FoodSchedule(name: newFoodScheduleNameController.text));
      newFoodScheduleNameController.text = "";
    }
  }

  void validateName(String value) {
    if (widget.foodscheduleNames
        .contains(newFoodScheduleNameController.text.trim())) {
      setState(() {
        errorString = "Duplicate name exists";
      });
    } else {
      setState(() {
        errorString = "";
      });
    }
  }

  void deleteFoodSchedule(int index) {
    widget.deleteFoodScheduleItem(index);
    validateName(newFoodScheduleNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    autofocus: false,
                    controller: newFoodScheduleNameController,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.all(9),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: errorString.isEmpty
                          ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                          : const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                      labelText: errorString.isEmpty
                          ? 'Food Schedule Name'
                          : errorString,
                      labelStyle: errorString.isEmpty
                          ? const TextStyle(color: Colors.blue)
                          : const TextStyle(color: Colors.red),
                    ),
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    onChanged: validateName,
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: widget.foodSchedules.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 50,
                    // child: Center(child: Text('Entry ${dinner[index]['name']}')),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 20, left: 0, right: 0),
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
      )),
    );
  }
}
