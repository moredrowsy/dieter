class User {
  final String username;
  final String email;
  String height; // in inches, in
  String weight; // in pounds, lbs
  String sex; // male or female
  String age;
  String bmi;
  String bmr;

  User(this.username, this.email, this.height, this.weight, this.sex, this.age,
      this.bmi, this.bmr);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        height = json['height'],
        weight = json['weight'],
        sex = json['sex'],
        age = json['age'],
        bmi = json['bmi'],
        bmr = json['bmr'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'height': height,
        'weight': weight,
        'sex': sex,
        'age': age,
        'bmi': bmi,
        'bmr': bmr,
      };
}
