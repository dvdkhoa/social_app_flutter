import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/post.dart';

class PostProvider extends ChangeNotifier {
  List<dynamic> _post = [];

  addPost(post) {
    _post.add(post);
    notifyListeners();
  }

  getPost(userId) async {
    _post = [] as List;

    final dio = Dio();

    final res =
        await dio.get('https://10.0.2.2:7284/api/Post/GetNews?userId=$userId');

    final map = Map<String, dynamic>.from(res.data);

    (map['data'] as List).forEach((element) {
      _post.add(element);
    });

    return _post;
  }
}
