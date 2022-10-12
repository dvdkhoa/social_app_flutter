import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/Post.dart';


class PostProvider extends ChangeNotifier{
  List<dynamic> _post = [];

  addPost(post)
  {
    _post.add(post);
    notifyListeners();
  }

  getPost(userId) {
    _post = [] as List;

    final dio = Dio();

    dio.get('https://10.0.2.2:7284/api/Post/GetNews?userId=$userId')
        .then((value) {
           final map = Map<String, dynamic>.from(value.data);

           // print(map['data']);
           int i = 1;
           (map['data'] as List).forEach((element) {
             // print(i++);
             _post.add(element);
             // print(element);
           });
           print(_post.length);
    });
    print(_post.length);
    return _post;
  }
}