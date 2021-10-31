import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/user.dart';
import 'package:dieter/utils/helpers.dart';

class SignupPage extends BasePage {
  const SignupPage({Key? key, required this.setUser})
      : super(key: key, title: "Signup");

  final Function setUser;

  @override
  BasePageState createState() => _SignupPageState();
}

class _SignupPageState extends BasePageState<SignupPage> {
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
                    autofocus: true,
                    controller: userController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    autofocus: true,
                    controller: passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    autofocus: true,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    autofocus: true,
                    controller: heightController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Height (in.)',
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    autofocus: true,
                    controller: weightController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Weight (lbs.)',
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    autofocus: true,
                    controller: ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: DropdownButton<String>(
                    value: sexDropdownValue,
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
