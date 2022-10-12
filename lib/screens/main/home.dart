import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';import 'package:get_storage/get_storage.dart';
import 'package:ltp/providers/posts.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostsProvider>(context);

    final postTempProvider = Provider.of<PostProvider>(context);

    var posts = postTempProvider.getPost(userLogin['userId']) as List;

    // print('length: '+ posts.count().toString());

    if(posts != null)
      print('posts: co du lieu');
    else
      print('post null');

    // print(posts[2]);


    var postList = postProvider.getpostListing;

    // print('length: '+ posts.length.toString());

    List<Widget> getList = posts.map((e) {
      return Container(
        child: Text('123'),
      );
    }).toList();

    return ListView(
      children: getList,
    );


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
