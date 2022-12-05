class GetModel {
  int? id;
  String? tasks;

  GetModel({this.id, this.tasks});

  GetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tasks = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task'] = tasks;
    return data;
  }
}
