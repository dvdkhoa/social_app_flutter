

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/post.dart';
import 'package:ltp/services/comment_service.dart';
import 'package:ltp/services/post_service.dart';

class PostsProvider extends ChangeNotifier {
  final userLogin = GetStorage().read('userLogin');

  final PostService _postService = PostService();
  final CommentService _commentService = CommentService();

  List<PostModel> _news = [];
  List<PostModel> _wall = [];
  List<PostModel> _myWall = [];

  List<Comments> _comments = [];

  bool isLoading = false;

  List<PostModel> get news => _news;
  List<PostModel> get wall => _wall;
  List<PostModel> get myWall => _myWall;

  List<Comments> get comments => _comments;



  Future<void> getNewsFromServer() async{
    isLoading = true;
    notifyListeners();

    _news = (await _postService.getNewsFromServer(userLogin['userId'])).reversed.toList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getWallFromServer(String userId) async{
    isLoading = true;
    notifyListeners();

    _wall = (await _postService.getWallFromServer(userId)).reversed.toList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMyWallFromServer() async{
    isLoading = true;
    notifyListeners();

    _myWall = (await _postService.getWallFromServer(userLogin['userId'])).reversed.toList();
    isLoading = false;
    notifyListeners();
  }


  Future<void> getCommentsFromServer(String postId) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _comments = await _commentService.getCommentsFromServer(postId);
    isLoading = false;
    notifyListeners();
  }

  Future<void> addCommentToPost(String text, String postId) async {
    final res = await Dio().post('https://10.0.2.2:7284/api/Post/Comment',
        data: {
          "userId": userLogin['userId'],
          "postId": postId,
          "text": text
        }
    );
    if(res.statusCode == 200){

      final map = Map<String, dynamic>.from(res.data);

      final newComment = Comments.fromJson(map['data']);

      final post = _news.where((element) => element.id == postId).first;
      post.comments?.add(newComment);
      _comments.add(newComment);
      notifyListeners();
    }
  }
}