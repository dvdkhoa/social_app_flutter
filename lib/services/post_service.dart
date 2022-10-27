import 'package:dio/dio.dart';
import 'package:ltp/models/post.dart';

class PostService {
  final dio = Dio();

  Future<List<PostModel>> getNewsFromServer(String userId) async {
    final res = await dio.get(
        'https://10.0.2.2:7284/api/Post/GetNews?userId=' + userId);

    List list = res.data['data'] as List;

    List<PostModel> posts = list.map((e) => PostModel.fromJson(e)).toList();

    return posts;
  }

  Future<List<PostModel>> getWallFromServer(String userId) async {
    final res = await dio.get(
        'https://10.0.2.2:7284/api/Post/GetWall?userId=' + userId);

    final map = Map<String, dynamic>.from(res.data);

    if(map['data'] != null) {
      List list = res.data['data'] as List;

      List<PostModel> posts = list.map((e) => PostModel.fromJson(e)).toList();

      return posts;
    }
    return [];
  }

  Future<void> updatePost(String postId, String text) async{
    final res = await dio.put(
        'https://10.0.2.2:7284/api/Post/UpdatePost?postId=${postId}&text=${text}');
  }

  Future<void> deletePost(String postId) async{
    final res = await dio.delete(
        'https://10.0.2.2:7284/api/Post/DeletePost?postId=${postId}');

  }
}