class FoodUser {
  String uid = "";
  final String username;
  final String email;
  double height; // in inches, in
  double weight; // in pounds, lbs
  String sex; // male or female
  int age;
  double bmi;
  double bmr;

  FoodUser(
      {this.uid = "",
      this.username = "",
      this.email = "",
      this.height = 0,
      this.weight = 0,
      this.sex = "",
      this.age = 0,
      this.bmi = 0,
      this.bmr = 0});

  FoodUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        username = json['username'],
        email = json['email'],
        height = double.parse(json['height']),
        weight = double.parse(json['weight']),
        sex = json['sex'],
        age = int.parse(json['age']),
        bmi = double.parse(json['bmi']),
        bmr = double.parse(json['bmr']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'height': height.toString(),
        'weight': weight.toString(),
        'sex': sex,
        'age': age.toString(),
        'bmi': bmi.toString(),
        'bmr': bmr.toString(),
      };
}
