import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food.dart';

class FoodsPage extends BasePage {
  FoodsPage({
    Key? key,
    required this.foods,
    required this.addFood,
    required this.removeFood,
  }) : super(key: key, title: "Foods");

  final List<Food> foods;
  final Function addFood;
  final Function removeFood;

  @override
  BasePageState createState() => _FoodsPageState();
}

class _FoodsPageState extends BasePageState<FoodsPage> {
  final foodNameController = TextEditingController();
  final foodCaloriesController = TextEditingController();

  void _addFood() {
    if (foodNameController.text != "" && foodCaloriesController.text != "") {
      try {
        int calories =
            double.parse(foodCaloriesController.text).round().toInt();
        widget.addFood(Food(name: foodNameController.text, calories: calories));
      } catch (e) {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 20, bottom: 0, left: 10, right: 10),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(9),
                      border: OutlineInputBorder(),
                      labelText: 'Food Name',
                    ),
                    controller: foodNameController,
                  ),
                  flex: 7,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: TextField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.all(9),
                        border: OutlineInputBorder(),
                        labelText: 'Calories',
                      ),
                      controller: foodCaloriesController,
                    ),
                  ),
                  flex: 3,
                ),
                Expanded(
                    child: Container(
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: _addFood,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    flex: 1)
              ]),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
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
                                widget.removeFood(index);
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
    );
  }
}
