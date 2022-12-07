class GetModel {
  int? id;
  String? tasks;
  String? key;
  GetModel({
    this.id,
    this.tasks,
  });

  GetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tasks = json['tasks'];
    // key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tasks'] = tasks;
    return data;
  }
}

class TaskList {
  List<GetModel> tasks = [];

  TaskList.fromJsonList(Map value) {
    value.forEach((key, value) {
      var task = GetModel.fromJson(value);
      task.key = key;
      tasks.add(task);
    });
  }
}
