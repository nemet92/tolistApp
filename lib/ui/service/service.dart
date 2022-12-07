import 'package:dio/dio.dart';
import 'package:tolesson/ui/model/get_Model.dart';
import 'package:tolesson/ui/model/post_modal.dart';
import 'package:tolesson/ui/model/post_user_model.dart';

abstract class ProjectService {
  Future<List<Posts>?> taskPost(Posts toDoPostModel);
  Future<void> infoPage(Users toDoPostModel);

  Future<List<GetModel>?> taskListCard();
}

class GeneralService extends ProjectService {
  Dio dio = Dio(BaseOptions(
      baseUrl: 'https://restapi-843b0-default-rtdb.firebaseio.com/'));

  @override
  Future<List<Posts>?> taskPost(Posts toDoPostModel) async {
    try {
      final response = await dio.post('nTasks.json', data: toDoPostModel);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  @override
  Future<void> infoPage(Users toDoPostModel) async {
    try {
      final response = await dio.post('nUsers.json', data: toDoPostModel);
      if (response.statusCode == 201) {
        return response.data;
      }
    } catch (error) {
      return;
    }
  }

// Future<List<TaskModel>?> fetchItemFromApi() async {
//     final response = await dio.get('task.json');
//     final jsonResponse = response.data;
//     if (response.statusCode == 200) {
//       final taskList= TaskList.fromJsonList(jsonResponse);
//       return taskList.task;
//     }
//     return null;
//   }

  @override
  Future<List<GetModel>?> taskListCard() async {
    final response = await dio.get('nTasks.json');
    final data = response.data;
    if (response.statusCode == 200) {
      if (response.statusCode == 200) {
        final taskList = TaskList.fromJsonList(data);
        return taskList.tasks;
      }
      // if (data is List) {
      //   return data.map((e) => Posts.fromJson(e)).toList();
      // }
    }
    return null;
  }
}
