import 'package:dio/dio.dart';
import 'package:ltp/models/post.dart';

class PostService {
  final dio = Dio();

  Future<List<Post>> getNewsFromServer(String userId) async {
    final res = await dio.get(
        'https://10.0.2.2:7284/api/Post/GetNews?userId=' + userId);

    List list = res.data['data'] as List;

    List<Post> posts = list.map((e) => Post.fromJson(e)).toList();

    return posts;
  }

  Future<List<Post>> getWallFromServer(String userId) async {
    final res = await dio.get(
        'https://10.0.2.2:7284/api/Post/GetWall?userId=' + userId);

    final map = Map<String, dynamic>.from(res.data);

    if(map['data'] != null) {
      List list = res.data['data'] as List;

      List<Post> posts = list.map((e) => Post.fromJson(e)).toList();

      return posts;
    }
    return [];
  }
}