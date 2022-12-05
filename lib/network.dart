import 'package:dio/dio.dart';
import 'package:tolesson/PostTaskModal.dart';
import 'package:tolesson/PostUserModel.dart';

abstract class ProjectService {
  Future<void> taskPost(Posts toDoPostModel);
  Future<void> infoPage(Users toDoPostModel);

  Future<List?> taskListCard();
}

class GeneralService extends ProjectService {
  Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));

  @override
  Future<void> taskPost(Posts toDoPostModel) async {
    try {
      final response = await dio.post('posts', data: toDoPostModel);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      return;
    }
  }

  @override
  Future<void> infoPage(Users toDoPostModel) async {
    try {
      final response = await dio.post('users', data: toDoPostModel);
      if (response.statusCode == 201) {
        return response.data;
      }
    } catch (error) {
      return;
    }
  }

  @override
  Future<List?> taskListCard() async {
    final response = await dio.get('posts');
    if (response.statusCode == 200) {
      final data = response.data;
      if (data is List) {
        return data.map((e) => Posts.fromJson(e)).toList();
      }
    }
    return null;
  }
}
