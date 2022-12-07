import 'package:dio/dio.dart';
import 'package:tolesson/ui/model/get_Model.dart';
import 'package:tolesson/ui/model/post_modal.dart';
import 'package:tolesson/ui/model/post_user_model.dart';

abstract class ProjectService {
  Future<List<Posts>?> taskPost(Posts toDoPostModel);
  Future<void> signIn(Users userModel);

  Future<List<GetRequestModel>?> taskListCard();
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
  Future<void> signIn(Users userModel) async {
    try {
      final response = await dio.post('nUsers.json', data: userModel);
      if (response.statusCode == 201) {
        return response.data;
      }
    } catch (error) {
      return;
    }
  }

  @override
  Future<List<GetRequestModel>?> taskListCard() async {
    final response = await dio.get('nTasks.json');
    final data = response.data;
    if (response.statusCode == 200) {
      if (response.statusCode == 200) {
        final taskList = TaskList.fromJsonList(data);
        return taskList.tasks;
      }
    }
    return null;
  }
}
