class User {
  final String username;
  final String password;
  final String email;
  String height; // in inches, in
  String weight; // in pounds, lbs
  String sex; // male or female
  String age;
  String bmi;
  String bmr;

  User(
      {this.username = "",
      this.password = "",
      this.email = "",
      this.height = "",
      this.weight = "",
      this.sex = "",
      this.age = "",
      this.bmi = "",
      this.bmr = ""});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        email = json['email'],
        height = json['height'],
        weight = json['weight'],
        sex = json['sex'],
        age = json['age'],
        bmi = json['bmi'],
        bmr = json['bmr'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'height': height,
        'weight': weight,
        'sex': sex,
        'age': age,
        'bmi': bmi,
        'bmr': bmr,
      };
}
