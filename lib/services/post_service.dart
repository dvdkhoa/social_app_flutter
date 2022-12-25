import 'package:dio/dio.dart';
import 'package:ltp/models/post.dart';

class PostService {
  final dio = Dio();

  Future<List<PostModel>> getNewsFromServer(String userId) async {
    print("UserId: "+userId);
    final res = await dio.get(
        'https://10.0.2.2:7284/api/Post/GetNews?userId=' + userId);

    if(res.data['data'] != null)
    {
      print(res.data);
      List list = res.data['data'] as List;
      List<PostModel> posts = list.map((e) => PostModel.fromJson(e)).toList();
      return posts;
    }
    else
      return [];
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
    print("delete: "+postId);
    final res = await dio.delete(
        'https://10.0.2.2:7284/api/Post/DeletePost?postId=${postId}');

  }

  Future<PostModel> creatPost (FormData formData) async {
    final res = await dio.post("https://10.0.2.2:7284/api/Post/CreatePost",
      data: formData,
    );

    if(res.statusCode == 200) {
      final newPostJson = res.data['data'];
      final PostModel postModel = PostModel.fromJson(newPostJson);

      return postModel;
    }
    throw Exception('Create post failed!!!');
  }

  Future<PostModel> getPost (String postId) async {
    final res = await dio.get('https://10.0.2.2:7284/api/Post/GetPost?postId=${postId}');

    // final map = Map<String, dynamic>.from(res.data);
    print(res.data);
    // print('abc');
    PostModel postModel = PostModel.fromJson(res.data);
    return postModel;
  }
}