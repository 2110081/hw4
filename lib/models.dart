class User {
  int? id;
  String username;
  String password;
  String email;
  String? phone;
  String? gender;
  Name? name;

  User({this.id, required this.username, required this.password, required this.email, this.phone, this.gender, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['login']['username'],
        password: json['login']['password'],
        email: json['email'],
        phone: json['phone'],
        gender: json['gender'],
        name: Name(
            first: json['name']['first'],
            last: json['name']['last'],
            title: json['name']['title'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'gender': gender,
      'title': name!.title,
      'first_name': name!.first,
      'last_name': name!.last,
    };
    return map;
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      name: Name(
        title: map['title'],
        first: map['first_name'],
        last: map['last_name'],
      ),
    );
  }
}

class Name {
  String? title;
  String? first;
  String? last;

  Name({
    this.title,
    this.first,
    this.last,
  });
}
