class User {
  String gender;
  Name name;
  String email;
  String phone;
  Picture picture;

  User({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        gender: json['gender'],
        name: Name(
            first: json['name']['first'],
            last: json['name']['last'],
            title: json['name']['title'],
      ),
        email: json['email'],
        phone: json['phone'],
        picture: Picture(
            thumbnail: json['picture']['thumbnail'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name.first,
    };
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });
}

class Picture {
  String thumbnail;

  Picture({
    required this.thumbnail,
  });
}
