import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: const [
                Expanded(
                  child: Center(
                    child: Text(
                      'Calories Limit',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('1500', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: const [
                Expanded(
                  child: Center(
                    child: Text(
                      'Goal',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('1300', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              children: const [
                Expanded(
                  child: Center(
                    child: Text(
                      'Current Calories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('652', style: TextStyle(fontSize: 18)),
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
                      margin: const EdgeInsets.only(top: 10),
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
              itemCount: lunch.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 50,
                    // child: Center(child: Text('Entry ${dinner[index]['name']}')),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
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
              itemCount: dinner.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 50,
                    // child: Center(child: Text('Entry ${dinner[index]['name']}')),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
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
                        ],
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
