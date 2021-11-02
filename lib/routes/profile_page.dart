import 'package:dieter/classes/base_page.dart';
import 'package:dieter/models/food_user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends BasePage {
  const ProfilePage({Key? key, required this.user, required this.setUser})
      : super(key: key, title: "Profile");

  final FoodUser user;
  final Function setUser;

  @override
  BasePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage> {
  bool isEdit = false;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final sexController = TextEditingController();
  final ageController = TextEditingController();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  void _toggleEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  void _saveProfile() {
    _toggleEdit();
    widget.user.height = double.parse(heightController.text);
    widget.user.weight = double.parse(weightController.text);
    widget.user.age = int.parse(ageController.text);
    widget.user.updateBMIAndBMR();

    widget.setUser(widget.user);
  }

  void _logout() {
    widget.setUser(FoodUser());
  }

  @override
  Widget build(BuildContext context) {
    heightController.text = widget.user.height.toString();
    weightController.text = widget.user.weight.toString();
    sexController.text = widget.user.sex;
    ageController.text = widget.user.age.toString();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20),
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
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
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
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
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
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
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
                    ? ElevatedButton(
                        style: style,
                        onPressed: _saveProfile,
                        child: const Text('Save'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
