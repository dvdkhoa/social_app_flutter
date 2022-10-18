import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/postmodel.dart';

class PostsProvider with ChangeNotifier {
  List<PostModel> _postList = [];


  final userLogin = GetStorage().read('userLogin');

  List<PostModel> get getpostListing {
    return [..._postList];
  }


   get getPostFromSV async{
    print(userLogin['userId']);
    Dio dio = Dio();
    final res = await dio.get('https://10.0.2.2:7284/api/Post/GetNews',
        queryParameters: {
          "userId": userLogin['userId']
        });

    if(res.statusCode == 200){
      print(res);
      return res.data;
    } else {
      throw Exception('fail');
    }
  }

  int get postListLength {
    return _postList.length;
  }

  void addToPostList(PostModel value) {
    _postList.add(value);
    GetStorage().write('postlist', _postList.asMap());
    notifyListeners();
    debugPrint('Notified');
  }

  void removePostfromList(value) {
    _postList.removeAt(value);
    notifyListeners();
  }

  void addCommenttoPost(index, comment) {
    _postList[index].comments.add(comment);
    notifyListeners();
  }

  void addLiketoPost(index, manwholikes) {
    _postList[index].likes.add(manwholikes);
    notifyListeners();
  }



  void getCommentsByPostId(String postId){
    // _postList.where((post) => post)
    _postList.forEach((element) {
      print(element);
    });
  }
}
