class ToDoUserModel {
  List<Users>? users;

  ToDoUserModel({this.users});

  ToDoUserModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? name;
  String? mail;
  int? age;

  Users({this.name, this.mail, this.age});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mail'] = mail;
    data['age'] = age;
    return data;
  }
}
