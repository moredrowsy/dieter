import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';
import 'package:dieter/classes/user.dart';
import 'package:dieter/utils/helpers.dart';

class Signup extends BasePage {
  const Signup({Key? key, required this.setUser})
      : super(key: key, title: "Signup");

  final Function setUser;

  @override
  BasePageState createState() => _SignupState();
}

class _SignupState extends BasePageState<Signup> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final sexController = TextEditingController();
  final ageController = TextEditingController();
  String sexDropdownValue = 'male';
  String errorString = "";

  void _signup() {
    try {
      if (userController.text == "") {
        throw Exception("Username can not be empty");
      }
      if (passController.text == "") {
        throw Exception("Password can not be empty");
      }
      if (emailController.text == "") {
        throw Exception("Email can not be empty");
      }
      if (!emailController.text.contains(RegExp(
          r"[a-zA-Z0-9!#$%&'*+\-\/=?^_`{|}~\.]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]{2,}"))) {
        throw Exception("Email must be valid");
      }
      if (heightController.text == "") {
        throw Exception("Height can not be empty");
      }
      if (weightController.text == "") {
        throw Exception("Weight can not be empty");
      }
      if (ageController.text == "") {
        throw Exception("Age can not be empty");
      }

      double weight = 0;
      try {
        weight = double.parse(weightController.text);
      } catch (e) {
        throw Exception("Weight must be a number");
      }

      double height = 0;
      try {
        height = double.parse(heightController.text);
      } catch (e) {
        throw Exception("Height must be a number");
      }

      int age = 0;
      try {
        age = int.parse(ageController.text);
      } catch (e) {
        throw Exception("Age must be a number");
      }

      setState(() {
        User user = User(
          username: userController.text,
          password: passController.text,
          email: emailController.text,
          height: height,
          weight: weight,
          sex: sexDropdownValue,
          age: age,
        );

        if (user.bmi == 0) {
          // Calculate BMI
          // https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_1.html
          double bmi = getBMI(
            user.height,
            user.weight,
          );
          user.bmi = bmi.round().toDouble();
        }

        if (user.bmr == 0) {
          // Calculate BMR
          // https://www.livestrong.com/article/382462-what-is-bmi-and-bmr/
          double bmr = getBMR(user.height, user.weight, user.age, user.sex);
          user.bmr = bmr.round().toDouble();
        }

        widget.setUser(user);

        Navigator.of(context).pop();
      });
    } catch (e) {
      setState(() {
        errorString = e.toString().replaceFirst("Exception: ", "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(errorString),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    controller: userController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    controller: passController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: emailController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Height (in.)',
                    ),
                    controller: heightController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Weight (lbs.)',
                    ),
                    controller: weightController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                    controller: ageController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: DropdownButton<String>(
                    value: sexDropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        sexDropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'male',
                      'female',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: OutlinedButton(
                    onPressed: _signup,
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
