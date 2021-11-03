import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food.dart';
import 'package:flutter/material.dart';

class FoodsPage extends BasePage {
  const FoodsPage({
    Key? key,
    required this.foods,
    required this.foodNames,
    required this.addFood,
    required this.removeFood,
  }) : super(key: key, title: "Foods");

  final List<Food> foods;
  final Set<String> foodNames;
  final Function addFood;
  final Function removeFood;

  @override
  BasePageState createState() => _FoodsPageState();
}

class _FoodsPageState extends BasePageState<FoodsPage> {
  String nameErrorString = "";
  String caloriesErrorString = "";
  final foodNameController = TextEditingController();
  final foodCaloriesController = TextEditingController();

  void _addFood() {
    if (foodNameController.text != "" &&
        foodCaloriesController.text != "" &&
        nameErrorString.isEmpty &&
        caloriesErrorString.isEmpty) {
      try {
        int calories =
            double.parse(foodCaloriesController.text).round().toInt();
        widget.addFood(Food(name: foodNameController.text, calories: calories));
        foodNameController.text = "";
        foodCaloriesController.text = "";
      } catch (e) {
        //
      }
    }
  }

  void validateName(String value) {
    if (widget.foodNames.contains(foodNameController.text.trim())) {
      setState(() {
        nameErrorString = "Duplicate name exists";
      });
    } else {
      setState(() {
        nameErrorString = "";
      });
    }
  }

  void removeFood(index) {
    widget.removeFood(index);
    validateName(foodNameController.text);
  }

  void validateCalories(value) {
    if (value.isNotEmpty) {
      try {
        if (double.parse(value) < 0) {
          setState(() {
            caloriesErrorString = "Positive only";
          });
        } else {
          setState(() {
            caloriesErrorString = "";
          });
        }
      } catch (e) {
        setState(() {
          caloriesErrorString = "Invalid";
        });
      }
    } else {
      setState(() {
        caloriesErrorString = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 10, right: 10),
                child: Row(children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.all(9),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: nameErrorString.isEmpty
                            ? const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                        labelText: nameErrorString.isEmpty
                            ? 'Food Name'
                            : nameErrorString,
                        labelStyle: nameErrorString.isEmpty
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.red),
                      ),
                      controller: foodNameController,
                      onChanged: validateName,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.all(9),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: caloriesErrorString.isEmpty
                              ? const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                )
                              : const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                          labelText: caloriesErrorString.isEmpty
                              ? 'Calories'
                              : caloriesErrorString,
                          labelStyle: caloriesErrorString.isEmpty
                              ? const TextStyle(color: Colors.blue)
                              : const TextStyle(color: Colors.red),
                        ),
                        controller: foodCaloriesController,
                        keyboardType: TextInputType.number,
                        onChanged: validateCalories,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: _addFood,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ]),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 8, left: 10),
                  itemCount: widget.foods.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 50,
                      child: Row(children: [
                        Expanded(
                          child: Text(widget.foods[index].name),
                          flex: 7,
                        ),
                        Expanded(
                            child: Container(
                              child: Text('${widget.foods[index].calories}'),
                              alignment: Alignment.centerRight,
                            ),
                            flex: 2),
                        Expanded(
                            child: Container(
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.blue,
                                onPressed: () {
                                  removeFood(index);
                                },
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            flex: 1)
                      ]),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
