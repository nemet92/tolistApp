import 'package:dio/dio.dart';
import 'package:tolesson/modelPost.dart';

abstract class ProjectService {
  Future<void> taskPost(Posts toDoPostModel);
  Future<void> infoPage(Posts toDoPostModel);
  Future<List?> fetchFromApiWithData();
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
  Future<void> infoPage(Posts toDoPostModel) async {
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
  Future<List?> fetchFromApiWithData() async {
    final response = await dio.get('users');
    if (response.statusCode == 200) {
      final value = Posts.fromJson(response.data);
      return null;
    }

    return null;
  }
}
