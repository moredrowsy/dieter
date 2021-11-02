import 'package:dieter/classes/base_page.dart';
import 'package:dieter/routes/signup_page.dart';
import 'package:dieter/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends BasePage {
  const LoginPage({
    Key? key,
    required this.setUser,
    required this.setFoods,
    required this.setFoodSchedules,
    required this.setFoodHistories,
  }) : super(key: key, title: "Login");

  final Function setUser;
  final Function setFoods;
  final Function setFoodSchedules;
  final Function setFoodHistories;

  @override
  BasePageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String errorString = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _login() {
    try {
      if (!emailController.text.contains(RegExp(
          r"[a-zA-Z0-9!#$%&'*+\-\/=?^_`{|}~\.]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]{2,}"))) {
        throw Exception("Email must be valid");
      }

      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          .then((value) {
        String uid = value.user!.uid;

        // Load user foods list
        fbHydrateFoods(uid, widget.setFoods);

        // Load user foodSchdules list
        fbfbHydrateFoodschedules(uid, widget.setFoodSchedules);

        // Load user foodHistories list
        fbHydrateFoodHistories(uid, widget.setFoodHistories);

        // Load user profile
        fbHydrateUser(uid, widget.setUser);
      }).catchError((error) {
        setState(() {
          if (error.code == 'user-not-found') {
            errorString = "User does not exist";
          } else if (error.code == 'wrong-password') {
            errorString = "Wrong password";
          } else if (error.code == 'too-many-requests') {
            errorString = "Too many attempts";
          } else {
            errorString = "Login failed";
          }
        });
      });
    } catch (e) {
      setState(() {
        errorString = e.toString().replaceFirst("Exception: ", "");
      });
    }
  }

  void _gotoSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupPage(
                setUser: widget.setUser,
                setFoods: widget.setFoods,
                setFoodSchedules: widget.setFoodSchedules,
                setFoodHistories: widget.setFoodHistories,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = "thuantang@gmail.com";
    passController.text = "123456";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
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
