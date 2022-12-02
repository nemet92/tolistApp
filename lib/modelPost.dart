class ToDoPostModel {
  List<Posts>? posts;

  ToDoPostModel({this.posts});

  ToDoPostModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int? id;
  String? tasks;
  String? name;
  String? mail;
  int? age;

  Posts({this.id, this.tasks, this.name, this.mail, this.age});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tasks = json['tasks'];
    name = json['name'];
    mail = json['mail'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tasks'] = tasks;
    data['name'] = name;
    data['mail'] = mail;
    data['age'] = age;
    return data;
  }
}
