import 'package:dieter/routes/signup.dart';
import 'package:flutter/material.dart';
import 'package:dieter/classes/base_page.dart';
import 'package:dieter/classes/user.dart';
import 'package:dieter/utils/helpers.dart';

class Login extends BasePage {
  const Login({Key? key, required this.setUser})
      : super(key: key, title: "Login");

  final Function setUser;

  @override
  BasePageState createState() => _LoginState();
}

class _LoginState extends BasePageState<Login> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final mockuser = User(
      username: "john",
      password: "test",
      email: "john@gmail.com",
      height: "64",
      weight: "130",
      sex: "male",
      age: "25");

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _login() {
    if (userController.text == mockuser.username &&
        passController.text == mockuser.password) {
      if (mockuser.bmi == "") {
        // Calculate BMI
        // https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_1.html
        double bmi = getBMI(
          double.parse(mockuser.height),
          double.parse(mockuser.weight),
        );
        mockuser.bmi = bmi.round().toString();
      }

      if (mockuser.bmr == "") {
        // Calculate BMR
        // https://www.livestrong.com/article/382462-what-is-bmi-and-bmr/
        double bmr = getBMR(
            double.parse(mockuser.height),
            double.parse(mockuser.weight),
            double.parse(mockuser.age),
            mockuser.sex);
        mockuser.bmr = bmr.round().toString();
      }

      widget.setUser(mockuser);
    }
  }

  void _gotoSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Signup(
                setUser: widget.setUser,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
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
              margin: const EdgeInsets.only(
                  top: 20, bottom: 15, left: 20, right: 20),
              child: OutlinedButton(
                onPressed: _login,
                child: const Text('Log in'),
              ),
            ),
            OutlinedButton(
              onPressed: _gotoSignup,
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
