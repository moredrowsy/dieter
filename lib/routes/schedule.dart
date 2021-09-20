import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final List<Map<String, String>> breakfast = [
    {'name': 'Oatmeal', 'calories': '158'},
    {'name': 'Milk', 'calories': '103'},
  ];
  final List<Map<String, String>> lunch = [
    {'name': 'Hamburger', 'calories': '390'},
    {'name': 'Gatorade', 'calories': '1'},
  ];
  final List<Map<String, String>> dinner = [
    {'name': 'Beef Bowl', 'calories': '600'}
  ];

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: const [
                Expanded(
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
                    child: Text('1252',
                        style: TextStyle(
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
              itemCount: breakfast.length,
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
                                child: Text('${breakfast[index]['calories']}',
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontStyle: FontStyle.italic))),
                          ),
                          Expanded(
                            child: Center(
                                child: Text('${breakfast[index]['name']}',
                                    style: const TextStyle(
                                        decoration:
                                            TextDecoration.lineThrough))),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              tooltip: 'Remove item',
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Add Breakfast Item'),
                  ),
                )
              ],
            ),
          ),
          const Text(
            'Lunch',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lunch.length,
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
                              child: Text('${lunch[index]['calories']}',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '${lunch[index]['name']}',
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              tooltip: 'Remove item',
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Add Lunch Item'),
                  ),
                )
              ],
            ),
          ),
          const Text(
            'Dinner',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dinner.length,
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
                              child: Text('${dinner[index]['calories']}',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '${dinner[index]['name']}',
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              tooltip: 'Remove item',
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Add Dinner Item'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
