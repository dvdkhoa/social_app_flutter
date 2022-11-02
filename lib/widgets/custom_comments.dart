import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/providers/custom_posts.dart';
import 'package:ltp/widgets/commentbox.dart';
import 'package:ltp/widgets/inputtext.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'custom_commentbox.dart';

class CustomCommentsPage extends StatefulWidget {
  CustomCommentsPage({Key? key}) : super(key: key);

  @override
  State<CustomCommentsPage> createState() => _CustomCommentsPageState();
}

class _CustomCommentsPageState extends State<CustomCommentsPage> {

  final userLogin = GetStorage().read('userLogin');
  String postId = Get.arguments.toString();

  late List _comments;
  bool _isLoading = true;

  Future<List> _getCommentsFromServer(String postId) async{
    print('postId'+postId);
    final res = await Dio().get('https://10.0.2.2:7284/api/Post/Comments?postId=$postId');
    await Future.delayed(Duration(seconds: 2));
    print('helo');
    print(res);

    final map = Map<String, dynamic>.from(res.data);

    final comments = map['data'] as List;

    print('list');
    print(comments);

    return comments;
  }

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final PostsProvider _postProvider = Provider.of<PostsProvider>(context, listen: false);
      _postProvider.getCommentsFromServer(postId);
    });

    // _getCommentsFromServer(postId).then((list) {
    //   setState(() {
    //     _comments = list;
    //     _isLoading = false;
    //   });
    // });


  }

  @override
  Widget build(BuildContext context) {

    final postProvider = Provider.of<PostsProvider>(context, listen: false);

    final texteditingcontroller = TextEditingController();


    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: 'Comments'.text.make(),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.8,
              child: Consumer<PostsProvider>(builder: (context, value, child) {
                if(value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemBuilder: ((context, index) {
                    return CustomCommentBox(
                      msg: value.comments[index].text.toString(),
                      imageUser: value.comments[index].by!.image.toString(),
                      userName: value.comments[index].by!.name.toString(),
                    );
                  }),
                  itemCount: value.comments.length,
                );
              },)
            ),
            CustomTextInputWidget(
              msgController: texteditingcontroller,
              performFunc: () {
                postProvider.addCommentToPost(texteditingcontroller.text, postId);
                texteditingcontroller.text = "";
              },
            ),
          ],
        ),
      ),
    );
  }

  // void _addComment(String text) async {
  //   final res = await Dio().post('https://10.0.2.2:7284/api/Post/Comment',
  //   data: {
  //     "userId": userLogin['userId'],
  //     "postId": postId,
  //     "text": text
  //   }
  //   );
  //   if(res.statusCode == 200){
  //
  //     final map = Map<String, dynamic>.from(res.data);
  //
  //     print(('data'));
  //     print(map['data']);
  //
  //     final newComment = map['data'] as dynamic;
  //     _comments.add(newComment);
  //     setState(() {
  //       print(_comments);
  //     });
  //   }
  // }
}
