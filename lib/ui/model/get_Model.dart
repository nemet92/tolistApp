class GetRequestModel {
  int? id;
  String? tasks;
  String? key;
  bool? isDone;
  GetRequestModel({
    this.id,
    this.tasks,
    this.isDone,
  });

  GetRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tasks = json['tasks'];
    isDone = json['isDone'];
    // key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tasks'] = tasks;
    data['isDone'] = isDone;
    return data;
  }
}

class TaskList {
  List<GetRequestModel> tasks = [];

  TaskList.fromJsonList(Map value) {
    value.forEach((key, value) {
      var task = GetRequestModel.fromJson(value);
      task.key = key;
      tasks.add(task);
    });
  }
}
