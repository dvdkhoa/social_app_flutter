

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/post.dart';
import 'package:ltp/services/comment_service.dart';
import 'package:ltp/services/post_service.dart';
import 'package:velocity_x/velocity_x.dart';

class PostsProvider extends ChangeNotifier {
  // final userLogin = GetStorage().read('userLogin');

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


  Future<void> creatPost(FormData formData) async {
    final PostModel newPost =(await _postService.creatPost(formData));

    print('trước: '+_news.length.toString());
    _news.add(newPost);
    _myWall.add(newPost);
    print('sau: '+_news.length.toString());

    notifyListeners();
  }

  Future<void> getNewsFromServer(String userId) async{
    isLoading = true;
    notifyListeners();

    _news = (await _postService.getNewsFromServer(userId)).reversed.toList();
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

  Future<void> getMyWallFromServer(String userId) async{
    isLoading = true;
    notifyListeners();

    _myWall = (await _postService.getWallFromServer(userId)).reversed.toList();
    isLoading = false;
    notifyListeners();
  }

  void clearMemory(){
    _news.clear();
    _wall.clear();
    _myWall.clear();
    _comments.clear();

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

  Future<void> addCommentToPost(String text, String postId, String userId) async {
    final res = await Dio().post('https://10.0.2.2:7284/api/Post/Comment',
        data: {
          "userId": userId,
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


  Future<void> updatePost(String postId, String text) async{
    await _postService.updatePost(postId, text);

    final post = _news.where((post) => post.id == postId).first;
    if(post == null)
      return;
    post.detail?.text = text;
    post.meta?.updated = DateTime.now().toString();
    notifyListeners();
  }

  Future<void> deletePost(String postId) async{
    await _postService.deletePost(postId);

    final post = _news.where((post) => post.id == postId).first;
    if(post == null)
      return;
    _news.remove(post);
    _myWall.remove(post);
    notifyListeners();
  }


  Future<void> sharePost(String postId, String userId) async{
    Dio dio = Dio();
    final res = await Dio().post('https://10.0.2.2:7284/api/Post/Share?userId=${userId}&postId=${postId}');

    final map = Map<String, dynamic>.from(res.data);

    PostModel newPost = PostModel.fromJson(map);
    _myWall.add(newPost);
    _news.add(newPost);
    notifyListeners();
  }
}