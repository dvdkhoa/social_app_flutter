import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/postmodel.dart';
import 'package:ltp/providers/custom_posts.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/custom_post-widget.dart';
import 'package:ltp/widgets/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class myProfilePage extends StatefulWidget {
  myProfilePage({Key? key}) : super(key: key);

  // bool isUserLogin;


  @override
  State<myProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<myProfilePage> {

  final userLogin = GetStorage().read('userLogin');

  List _list = [];

  Future? _callAPI = null;

  Future _callAPIPost() async {
    final dio = Dio();
    final res = await dio.get('https://10.0.2.2:7284/api/Post/GetWall?userId='+userLogin['userId']);

    final map = Map<String, dynamic>.from(res.data);

    var list = map['data'] as List;

    return list;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postProvider = Provider.of<PostsProvider>(context, listen: false);
      postProvider.getMyWallFromServer();
    });

    _callAPI = _callAPIPost();

    _callAPI?.then((list) {
      setState(() {
        _list = list;
        _list = _list.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var postmodel = PostModel();

    void _onButtonPressed(bool isChoose, int change) {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          height: 150,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
          ),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: change == 0 ? Text('View Avatar') : Text('View Background'),
              onTap:(){
                if(isChoose){
                  showDialog(context: context, builder: (context) => AlertDialog(
                    content: Stack(
                      alignment: Alignment.center,
                      children: [

                        Image.network(userLogin['profile']['image'],
                            fit: BoxFit.cover,
                            height: 200)
                      ],
                    ),
                  ));
                } else{
                  showDialog(context: context, builder: (context) => AlertDialog(
                    content: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(postmodel.user.bannerImage,
                            fit: BoxFit.cover,
                            height: 200)
                      ],
                    ),
                  ));
                }

                // Get.toNamed('/changeavata');
              },
            ),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: change == 0 ? Text('Change Avatar') : Text('Change Background'),
              onTap:(){
                print('change '+change.toString());
                Get.toNamed('/changeavata',arguments: change);
              },
            ),
          ],),
        );
      });
    }






    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height * 0.5,
                ),
                // Column(
                //   children: [
                //     // InkWell(
                //     //   onTap: () => _onButtonPressed(),
                //     // ),
                    InkWell(
                      onTap: () => _onButtonPressed(false, 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          image: DecorationImage(
                            image: NetworkImage(
                              postmodel.user.bannerImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: Get.height * 0.25,
                      ),
                    ),
                //   ],
                // ),

                Positioned(
                  left: Get.width * 0.2,
                  right: Get.width * 0.2,
                  bottom: 15,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => _onButtonPressed(true, 0),
                        child: CircleAvatar(
                          backgroundColor: ktxtwhiteColor,
                          radius: Get.height * 0.105,

                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage(userLogin['profile']['image']),
                            radius: Get.height * 0.1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userLogin['profile']['name'].toString().text
                          // postmodel.user.name.text.bold
                              .minFontSize(Get.textScaleFactor * 22)
                              .letterSpacing(2)
                              .makeCentered(),
                          postmodel.user.bio.text
                              .fontWeight(FontWeight.w500)
                              .minFontSize(Get.textScaleFactor * 16)
                              .color(Colors.blue)
                              .letterSpacing(1)
                              .makeCentered(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      postmodel.user.followings.text
                                          .fontWeight(FontWeight.w600)
                                          .minFontSize(Get.textScaleFactor * 18)
                                          .make(),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      'Followings'
                                          .text
                                          .minFontSize(Get.textScaleFactor)
                                          .make(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      postmodel.user.followings.text
                                          .fontWeight(FontWeight.w600)
                                          .minFontSize(Get.textScaleFactor * 18)
                                          .make(),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      'Followings'
                                          .text
                                          .minFontSize(Get.textScaleFactor)
                                          .make(),
                                    ],
                                  ),
                                ]),
                          ),
                          InkWell(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: Get.height * 0.04,
                                width: Get.width * 0.2,
                                color: kaccentColor,
                                child: 'Follow'
                                    .text
                                    .color(Colors.white)
                                    .makeCentered(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            'Posts'.text.minFontSize(18).letterSpacing(1).bold.makeCentered(),
            _list.isEmpty
                ? SizedBox(
              child: 'No Posts available'.text.makeCentered(),
              height: Get.height * 0.3,
            )
            // : ListView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemBuilder: (context, index) {
            //       return index % 2 == 0
            //           ? FadeInLeft(
            //               duration: const Duration(milliseconds: 600),
            //               from: 400,
            //               child: PostWidget(
            //                 datamodel: listp[index],
            //                 index: index,
            //               ),
            //             )
            //           : FadeInRight(
            //               duration: const Duration(milliseconds: 600),
            //               from: 400,
            //               child: PostWidget(
            //                 datamodel: listp[index],
            //                 index: index,
            //               ),
            //             );
            //     },
            //     itemCount: listp.length,
            //   ),
                : Consumer<PostsProvider>(builder: (context, value, child) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      int actualindex = value.myWall.length - index - 1;
                      return index % 2 == 0
                          ? ElasticInLeft(
                          duration: const Duration(milliseconds: 600),
                          from: 400,
                          child: CustomPostWidget(
                            post: value.myWall[actualindex],
                            index: actualindex,
                          ))
                          : ElasticInRight(
                          duration: const Duration(milliseconds: 600),
                          from: 400,
                          child: CustomPostWidget(
                            post: value.myWall[actualindex],
                            index: actualindex,
                          ));
                    }),
                    itemCount: _list.length,
                  );
                },)
          ],
        ),
      ),
    );
  }




}


