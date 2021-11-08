import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food_user.dart';
import 'package:dieter/routes/login_page.dart';
import 'package:dieter/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends BasePage {
  const ProfilePage(
      {Key? key,
      required this.user,
      required this.setUser,
      required this.setFoods,
      required this.setFoodSchedules,
      required this.setFoodHistories})
      : super(key: key, title: "Profile");

  final FoodUser user;
  final Function setUser;
  final Function setFoods;
  final Function setFoodSchedules;
  final Function setFoodHistories;

  @override
  BasePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage> {
  bool isEdit = false;
  String errorString = "";
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  void _toggleEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  void _cancelEdit() {
    _resetFields();
    _toggleEdit();
    setState(() {
      errorString = "";
    });
  }

  void _saveProfile() {
    if (errorString.isEmpty) {
      _toggleEdit();
      widget.user.height = double.parse(heightController.text);
      widget.user.weight = double.parse(weightController.text);
      widget.user.age = int.parse(ageController.text);
      widget.user.updateBMIAndBMR();
      widget.setUser(widget.user);
    }
  }

  void _logout() {
    FirebaseAuth.instance.signOut();
  }

  void _validateNumberInput(value) {
    if (value.isEmpty) {
      setState(() {
        errorString = "Can not be empty";
      });
    } else {
      try {
        if (double.parse(value) < 1) {
          setState(() {
            errorString = "Age must be positive";
          });
        } else {
          setState(() {
            errorString = "";
          });
        }
      } catch (e) {
        setState(() {
          errorString = "Invalid number";
        });
      }
    }
  }

  void _resetFields() {
    heightController.text = widget.user.height.toString();
    weightController.text = widget.user.weight.toString();
    ageController.text = widget.user.age.toString();
  }

  Future<void> _removeUser() async {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    fbRemoveUserAccount(firebaseUser, () {
      // Go to login page to reauth
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  setUser: widget.setUser,
                  setFoods: widget.setFoods,
                  setFoodSchedules: widget.setFoodSchedules,
                  setFoodHistories: widget.setFoodHistories,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isEdit) {
      _resetFields();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Center(
                    child: errorString.isEmpty
                        ? const Text("")
                        : Text(
                            errorString,
                            style: const TextStyle(color: Colors.red),
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 6, left: 6, right: 6),
                            child: Text(
                              widget.user.username,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 6, left: 6, right: 6),
                            child: Text(
                              widget.user.email,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Height (in.)',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: isEdit
                              ? TextField(
                                  textAlign: TextAlign.center,
                                  autofocus: false,
                                  controller: heightController,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  onChanged: _validateNumberInput,
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 5, bottom: 6, left: 6, right: 6),
                                  child: Text(
                                    widget.user.height.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Weight (lbs.)',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: isEdit
                              ? TextField(
                                  textAlign: TextAlign.center,
                                  autofocus: false,
                                  controller: weightController,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  onChanged: _validateNumberInput,
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 5, bottom: 6, left: 6, right: 6),
                                  child: Text(
                                    widget.user.weight.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: isEdit
                              ? TextField(
                                  textAlign: TextAlign.center,
                                  autofocus: false,
                                  controller: ageController,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  onChanged: _validateNumberInput,
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 5, bottom: 6, left: 6, right: 6),
                                  child: Text(
                                    widget.user.age.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Sex',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 6, left: 6, right: 6),
                            child: Text(
                              widget.user.sex,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'BMI',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 6, left: 6, right: 6),
                            child: Text(
                              widget.user.bmi.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'BMR',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 6, left: 6, right: 6),
                            child: Text(
                              widget.user.bmr.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                isEdit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: ElevatedButton(
                              style: style,
                              onPressed: _saveProfile,
                              child: const Text('Save'),
                            ),
                          ),
                          ElevatedButton(
                            style: style,
                            onPressed: _cancelEdit,
                            child: const Text('X'),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        style: style,
                        onPressed: _toggleEdit,
                        child: const Text('Edit'),
                      ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: style,
                  onPressed: _logout,
                  child: const Text('Log out'),
                ),
                const SizedBox(height: 55),
                ElevatedButton(
                  style: style,
                  onPressed: _removeUser,
                  child: const Text('Remove Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
