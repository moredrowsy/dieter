import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food.dart';
import 'package:dieter/models/food_schedule.dart';

class FoodScheduleEditPage extends BasePage {
  FoodScheduleEditPage({
    Key? key,
    required this.foods,
    required this.foodSchedules,
    required this.foodScheduleIndex,
    required this.updateFoodScheduleItem,
  }) : super(key: key, title: "Food Schedule Edit");

  final List<Food> foods;
  final List<FoodSchedule> foodSchedules;
  final int foodScheduleIndex;
  final Function updateFoodScheduleItem;

  @override
  BasePageState createState() => _FoodScheduleEditPageState();
}

class _FoodScheduleEditPageState extends BasePageState<FoodScheduleEditPage> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
  final foodScheduleNameController = TextEditingController();
  int foodsIndex = 0;

  void addBreakfast() {
    widget.foodSchedules[widget.foodScheduleIndex].addBreakfast(Food(
        name: widget.foods[foodsIndex].name,
        calories: widget.foods[foodsIndex].calories));
    widget.updateFoodScheduleItem(widget.foodScheduleIndex,
        widget.foodSchedules[widget.foodScheduleIndex]);
  }

  void removeBreakfast(int index) {
    widget.foodSchedules[widget.foodScheduleIndex].removeBreakfast(index);
    widget.updateFoodScheduleItem(widget.foodScheduleIndex,
        widget.foodSchedules[widget.foodScheduleIndex]);
  }

  void addLunch() {
    widget.foodSchedules[widget.foodScheduleIndex].addLunch(Food(
        name: widget.foods[foodsIndex].name,
        calories: widget.foods[foodsIndex].calories));
    widget.updateFoodScheduleItem(widget.foodScheduleIndex,
        widget.foodSchedules[widget.foodScheduleIndex]);
  }

  void removeLunch(int index) {
    widget.foodSchedules[widget.foodScheduleIndex].removeLunch(index);
    widget.updateFoodScheduleItem(widget.foodScheduleIndex,
        widget.foodSchedules[widget.foodScheduleIndex]);
  }

  void addDinner() {
    widget.foodSchedules[widget.foodScheduleIndex].addDinner(Food(
        name: widget.foods[foodsIndex].name,
        calories: widget.foods[foodsIndex].calories));
    widget.updateFoodScheduleItem(widget.foodScheduleIndex,
        widget.foodSchedules[widget.foodScheduleIndex]);
  }

  void removeDinner(int index) {
    widget.foodSchedules[widget.foodScheduleIndex].removeDinner(index);
    widget.updateFoodScheduleItem(widget.foodScheduleIndex,
        widget.foodSchedules[widget.foodScheduleIndex]);
  }

  void saveFoodScheduleName() {
    widget.foodSchedules[widget.foodScheduleIndex].name =
        foodScheduleNameController.text.trim();
    widget.updateFoodScheduleItem(widget.foodScheduleIndex,
        widget.foodSchedules[widget.foodScheduleIndex]);
  }

  @override
  Widget build(BuildContext context) {
    List<String> foodNames = widget.foods.map((e) => e.name).toList();
    String currentFoodName = widget.foods[foodsIndex].name;
    foodScheduleNameController.text =
        widget.foodSchedules[widget.foodScheduleIndex].name;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    autofocus: false,
                    controller: foodScheduleNameController,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(9),
                      border: OutlineInputBorder(),
                      labelText: 'Edit Food Schedule Name',
                    ),
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.save, size: 18),
                    tooltip: 'Save Food Schedule Name',
                    padding: EdgeInsets.zero,
                    onPressed: saveFoodScheduleName,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
            child: DropdownButton<String>(
              value: currentFoodName,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              isExpanded: true,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  currentFoodName = newValue!;
                  foodsIndex = foodNames.indexOf(currentFoodName);
                });
              },
              items: foodNames.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, left: 0, right: 2),
                    child: ElevatedButton(
                      style: style,
                      onPressed: addBreakfast,
                      child: const Text('+ Breakfast'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, left: 0, right: 2),
                    child: ElevatedButton(
                      style: style,
                      onPressed: addLunch,
                      child: const Text('+ Lunch'),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: style,
                    onPressed: addDinner,
                    child: const Text('+ Dinner'),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Total Calories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                        '${widget.foodSchedules[widget.foodScheduleIndex].totalCalories}',
                        style: const TextStyle(
                          fontSize: 18,
                        )),
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
              itemCount: widget
                  .foodSchedules[widget.foodScheduleIndex].breakfast.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 50,
                    // child: Center(child: Text('Entry ${dinner[index]['name']}')),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: Text(
                              '${widget.foodSchedules[widget.foodScheduleIndex].breakfast[index].calories}',
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              widget.foodSchedules[widget.foodScheduleIndex]
                                  .breakfast[index].name,
                            )),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              tooltip: 'Remove item',
                              padding: EdgeInsets.zero,
                              onPressed: () => removeBreakfast(index),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
          const Text(
            'Lunch',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  widget.foodSchedules[widget.foodScheduleIndex].lunch.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 50,
                    // child: Center(child: Text('Entry ${dinner[index]['name']}')),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: Text(
                              '${widget.foodSchedules[widget.foodScheduleIndex].lunch[index].calories}',
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              widget.foodSchedules[widget.foodScheduleIndex]
                                  .lunch[index].name,
                            )),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              tooltip: 'Remove item',
                              padding: EdgeInsets.zero,
                              onPressed: () => removeLunch(index),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
          const Text(
            'Dinner',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  widget.foodSchedules[widget.foodScheduleIndex].dinner.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 50,
                    // child: Center(child: Text('Entry ${dinner[index]['name']}')),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: Text(
                              '${widget.foodSchedules[widget.foodScheduleIndex].dinner[index].calories}',
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              widget.foodSchedules[widget.foodScheduleIndex]
                                  .dinner[index].name,
                            )),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              tooltip: 'Remove item',
                              padding: EdgeInsets.zero,
                              onPressed: () => removeDinner(index),
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
