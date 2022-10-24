
import 'package:dio/dio.dart';
import 'package:ltp/models/post.dart';

class CommentService {
  Future<List<Comments>> getCommentsFromServer(String postId) async{

    final res = await Dio().get('https://10.0.2.2:7284/api/Post/Comments?postId=$postId');

    final map = Map<String, dynamic>.from(res.data);

    final commentsArr = map['data'] as List;

    List<Comments> comments = commentsArr.map((e) => Comments.fromJson(e)).toList();

    return comments;
  }
}