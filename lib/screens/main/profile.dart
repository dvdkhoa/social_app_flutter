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

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userLogin = GetStorage().read('userLogin');

  bool isFollow = false;

  dynamic _user;

  String userId = Get.arguments.toString();



  Future _callAPIGetUser() async{
    final dio = Dio();
    final res = await dio.get('https://10.0.2.2:7284/api/Account/GetUser?userId='+userId);
    final map = Map<String, dynamic>.from(res.data);

    return map;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_) {
       final postProvider = Provider.of<PostsProvider>(context, listen: false);
       postProvider.getWallFromServer(userId);
     });

    _callAPIGetUser().then((user) {
      setState(() {
        _user = user;
        final map = Map<String, dynamic>.from(_user['followers']);

        isFollow = map.containsKey(userLogin['userId']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var postmodel = PostModel();
    print('222');
    print(userId);

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
                Container(
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
                Positioned(
                  left: Get.width * 0.2,
                  right: Get.width * 0.2,
                  bottom: 15,
                  child: _user != null ? Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: ktxtwhiteColor,
                        radius: Get.height * 0.105,
                        child: CircleAvatar(
                          backgroundImage:
                              // NetworkImage(userLogin['profile']['image']),
                          NetworkImage(_user['profile']['image']),
                          radius: Get.height * 0.1,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // userLogin['profile']['name'].toString().text
                          // postmodel.user.name.text.bold
                      _user['profile']['name'].toString().text
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
                            onTap: () async{
                              Dio dio = Dio();
                              var res = await dio.post('https://10.0.2.2:7284/api/Account/Follow',
                                data: {
                                  "userId": userLogin['userId'],
                                  "destId": userId
                                }
                              );
                              print(res);
                              if(res.data){
                                setState(() {
                                  print('object');
                                  print(isFollow);
                                  isFollow = !isFollow;
                                  print(isFollow);
                                });
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: Get.height * 0.04,
                                width: Get.width * 0.2,
                                color: kaccentColor,
                                child: !isFollow ? 'Follow'
                                    .text
                                    .color(Colors.white)
                                    .makeCentered()
                                    : 'Followed'
                                    .text
                                    .color(Colors.white)
                                    .makeCentered().backgroundColor(Colors.black38),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  // : CircularProgressIndicator(),
                  : const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color?>(
                        Colors.blueAccent,
                      ),
                    ),
                  )
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
             Consumer<PostsProvider>(builder: (context, value, child) {
               return value.wall.isEmpty
                   ? SizedBox(
                 child: 'No Posts available'.text.makeCentered(),
                 height: Get.height * 0.3,
               )
                   : ListView.builder(
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: ((context, index) {
                   int actualindex = value.wall.length - index - 1;
                   return index % 2 == 0
                       ? ElasticInLeft(
                       duration: const Duration(milliseconds: 600),
                       from: 400,
                       child: CustomPostWidget(
                         post: value.wall[actualindex],
                         index: actualindex,
                       ))
                       : ElasticInRight(
                       duration: const Duration(milliseconds: 600),
                       from: 400,
                       child: CustomPostWidget(
                         post: value.wall[actualindex],
                         index: actualindex,
                       ));
                 }),
                 itemCount: value.wall.length,
               );
             },)
          ],
        ),
      ),
    );
  }
}
