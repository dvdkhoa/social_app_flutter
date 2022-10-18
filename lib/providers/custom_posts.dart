

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class PostsProvider extends ChangeNotifier {
  final userLogin = GetStorage().read('userLogin');
  List _posts = [];
  final dio = Dio();


  List getPosts() {
    return _posts;
  }

  Future<List<dynamic>> getPostsFromServer() async{

    final res = await dio.get('https://10.0.2.2:7284/api/Post/GetNews?userId='+userLogin['userId']);

    final map = Map<String, dynamic>.from(res.data);

    var list = map['data'] as List;

    return list;
  }
}