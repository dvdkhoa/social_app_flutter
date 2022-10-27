import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltp/models/postmodel.dart';
import 'package:ltp/providers/custom_posts.dart';
import 'package:ltp/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final userLogin = GetStorage().read("userLogin");

  late PostsProvider _postProvider;

  var formController = TextEditingController();

  String postId = Get.arguments.toString();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postProvider = Provider.of<PostsProvider>(context, listen: false);
  }

  // WidgetsBinding.instance.addPostFrameCallback((_){
  // final postProvider = Provider.of<PostsProvider>(context, listen: false);
  // postProvider.getNewsFromServer();
  // });


  void submitPost() async{
    _postProvider.updatePost(postId, formController.text);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {

    final post = _postProvider.news.where((element) => element.id == postId).first;

    if(post == null)
      return Center(
        child: Text("Not found"),
      );

    formController.text = post.detail!.text!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: 'Post Screen'.text.make(),
      ),
      body: SizedBox(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Write Something about your post',
                  ),
                  controller: formController,
                ),
              ),
              const Spacer(),
              Container(
                width: Get.width * 0.7,
                height: Get.height * 0.1,
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: ElevatedButton(
                  onPressed: () async{
                    submitPost();
                  },
                  child: 'Upload'
                      .text
                      .minFontSize(20)
                      .fontWeight(FontWeight.w500)
                      .make(),
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
