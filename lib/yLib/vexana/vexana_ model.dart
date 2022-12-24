import 'package:vexana/vexana.dart';

class VexanaModel extends INetworkModel<VexanaModel> {
  String? email;
  String? password;
  String? key;

  VexanaModel({this.email, this.password});
  VexanaModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  VexanaModel fromJson(Map<String, dynamic> json) {
    return VexanaModel.fromJson(json);
  }
}

class VexanaList {
  List<VexanaModel> tasks = [];
  VexanaList.fromJsonList(Map value) {
    value.forEach((key, value) {
      var task = VexanaModel.fromJson(value);
      task.key = key;
      tasks.add(task);
    });
  }
}
