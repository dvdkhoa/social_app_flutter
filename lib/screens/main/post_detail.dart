
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltp/models/post.dart';
import 'package:ltp/services/post_service.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/custom_post-widget.dart';

class PostDetail extends StatefulWidget {
  PostDetail({Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  PostModel? postModel = null;

  PostService _postService = PostService();
  String postId = Get.arguments;

  @override
  void initState() {
    super.initState();

    _postService.getPost(postId).then((post) {
      setState(() {
        postModel = post;
        print(postModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if(postModel == null){
      return const Scaffold(
        body:  Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      // body: CustomPostWidget(
      //   post: postModel!, index: 0,
      // ),
      appBar: AppBar(
        title: Text('Post detail'),
      ),
      backgroundColor: kbgColor,
      body: ListView(
        children: [
          ElasticInLeft(
              duration: const Duration(milliseconds: 1000),
              from: 200,
              child: CustomPostWidget(
                post: postModel!,
                index: 0,
              )),
        ],
      )
    );
  }
}
