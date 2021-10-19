class User {
  final String username;
  final String password;
  final String email;
  double height; // in inches, in
  double weight; // in pounds, lbs
  String sex; // male or female
  int age;
  double bmi;
  double bmr;

  User(
      {this.username = "",
      this.password = "",
      this.email = "",
      this.height = 0,
      this.weight = 0,
      this.sex = "",
      this.age = 0,
      this.bmi = 0,
      this.bmr = 0});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        email = json['email'],
        height = double.parse(json['height']),
        weight = double.parse(json['weight']),
        sex = json['sex'],
        age = int.parse(json['age']),
        bmi = double.parse(json['bmi']),
        bmr = double.parse(json['bmr']);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'height': height.toString(),
        'weight': weight.toString(),
        'sex': sex,
        'age': age.toString(),
        'bmi': bmi.toString(),
        'bmr': bmr.toString(),
      };
}
