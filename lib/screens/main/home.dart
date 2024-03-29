import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/post.dart';
import 'package:ltp/models/user_login.dart';
import 'package:ltp/providers/custom_posts.dart';

import 'package:ltp/widgets/custom_post-widget.dart';
import 'package:ltp/widgets/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../providers/post_temp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userLogin = GetStorage().read('userLogin');

  List<PostModel> _news = [];
  
  List _list = [];

  Future? _callAPI = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      final postProvider = Provider.of<PostsProvider>(context, listen: false);
      final user = User.fromJson(GetStorage().read('userLogin'));
      postProvider.getNewsFromServer(user.userId.toString());
    });


    // _callAPI = _callAPIPost();
    //
    // _callAPI?.then((list) {
    //   setState(() {
    //     _list = list;
    //     _list = _list.reversed.toList();
    //   });
    // });
  }


  Future _callAPIPost() async {
    final dio = Dio();
    final res = await dio.get('https://10.0.2.2:7284/api/Post/GetNews?userId='+userLogin['userId']);

    final map = Map<String, dynamic>.from(res.data);

    var list = map['data'] as List;

    return list;
  }


  @override
  Widget build(BuildContext context) {

    // final postProvider = Provider.of<PostsProvider>(context);
    // postProvider.getPostsFromServer();

    // var postList = postProvider.getpostListing;

    // _postsProvider = Provider.of<PostsProvider>(context);


    return Consumer<PostsProvider>(builder: (context, value, child) {
      if (value.isLoading){
        return const Center(
            child: CircularProgressIndicator());
      }

      return ListView.builder(
        key: const PageStorageKey<String>("controllerHome"),
        itemBuilder: ((context, index) {
          int actualindex = value.news.length - index - 1;
          return index % 2 == 0
              ? ElasticInLeft(
              duration: const Duration(milliseconds: 600),
              from: 400,
              child: CustomPostWidget(
                post: value.news[actualindex],
                index: actualindex,
              ))
              : ElasticInRight(
              duration: const Duration(milliseconds: 600),
              from: 400,
              child: CustomPostWidget(
                post: value.news[actualindex],
                index: actualindex,
              ));
        }),
        itemCount: value.news.length,
      );
    });


    // return ListView.builder(
    //   itemBuilder: ((context, index) {
    //     int actualindex = postList.length - index - 1;
    //     return index % 2 == 0
    //         ? ElasticInLeft(
    //             duration: const Duration(milliseconds: 600),
    //             from: 400,
    //             child: PostWidget(
    //                 datamodel: postList[actualindex], index: actualindex))
    //         : ElasticInRight(
    //             duration: const Duration(milliseconds: 600),
    //             from: 400,
    //             child: PostWidget(
    //                 datamodel: postList[actualindex], index: actualindex));
    //   }),
    //   itemCount: postList.length,
    // );
  }
}
