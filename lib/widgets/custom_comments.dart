import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/providers/posts.dart';
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

    _getCommentsFromServer(postId).then((list) {
      setState(() {
        _comments = list;
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final myprovider = Provider.of<PostsProvider>(context);
    // var list = myprovider.getpostListing;
    final texteditingcontroller = TextEditingController();
    // final postindex = Get.arguments;
    //
    // void addcommenttoList() {
    //   myprovider.addCommenttoPost(postindex, texteditingcontroller.text);
    // }

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
              child: !_isLoading == true ?  ListView.builder(
                itemBuilder: ((context, index) {
                  return CustomCommentBox(
                    msg: _comments[index]['text'],
                    imageUser: _comments[index]['by']['image'],
                    userName: _comments[index]['by']['name'],
                  );
                }),
                itemCount: _comments.length,
              )
              : CircularProgressIndicator(),
              //color: Colors.blue,
            ),
            CustomTextInputWidget(
              msgController: texteditingcontroller,
              // performFunc: addcommenttoList,
              performFunc: () {
                _addComment(texteditingcontroller.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addComment(String text) async {
    final res = await Dio().post('https://10.0.2.2:7284/api/Post/Comment',
    data: {
      "userId": userLogin['userId'],
      "postId": postId,
      "text": text
    }
    );
    if(res.statusCode == 200){
      print('datares');

      final map = Map<String, dynamic>.from(res.data);
      
      print(('data'));
      print(map['data']);

      final newComment = map['data'] as dynamic;
      _comments.add(newComment);
      setState(() {
        print(_comments);
      });
    }
  }
}
