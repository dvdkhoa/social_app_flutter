import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/postmodel.dart';
import 'package:ltp/providers/common_provider.dart';
import 'package:ltp/providers/custom_posts.dart';
import 'package:ltp/providers/navbar.dart';
import 'package:ltp/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userLogin = GetStorage().read('userLogin');

    final navBarProvider = Provider.of<NavBarProvider>(context, listen: false);
    final postProvider = Provider.of<PostsProvider>(context, listen: false);

    navBarProvider.setFollow(userLogin['userId']);

    final followers = navBarProvider.getFollow();


    var postmodel = PostModel();
    return Container(
      decoration: BoxDecoration(
        color: kbgColor,
        border: Border.all(color: kaccentColor, width: 2),
      ),
      height: Get.height,
      width: Get.width * 0.6,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: Get.width * 0.3,
                        height: Get.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            // image: NetworkImage(postmodel.user.profileImage),
                            image: NetworkImage(userLogin['profile']['image'])
                          ),
                          border: Border.all(color: kaccentColor, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: kaccentColor.withOpacity(0.4),
                              blurRadius: 6,
                              spreadRadius: 1,
                              //offset: const Offset(3, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 3, left: 10),
                      // child: postmodel.user.name.text.bold
                        child: userLogin['profile']['name'].toString().text.bold
                          .wordSpacing(2)
                          .letterSpacing(0.5)
                          .minFontSize(Get.textScaleFactor * 20)
                          .make(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                      child: postmodel.user.bio.text
                          .color(Colors.blue)
                          .minFontSize(Get.textScaleFactor)
                          .make(),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // postmodel.user.followings.text
                          // followers!.length.text
                          "0".text
                              .fontWeight(FontWeight.w600)
                              .minFontSize(Get.textScaleFactor * 18)
                              .make(),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),
                          'Followings'
                              .text
                              .minFontSize(Get.textScaleFactor)
                              .make(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // postmodel.user.followers.text
                          followers.text
                              .fontWeight(FontWeight.w600)
                              .minFontSize(Get.textScaleFactor * 18)
                              .make(),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),
                          'Followers'
                              .text
                              .minFontSize(Get.textScaleFactor)
                              .make(),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/myprofilepage');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.person),
                            ),
                            'View Profile'
                                .text
                                .wordSpacing(3)
                                .fontWeight(FontWeight.w600)
                                .minFontSize(Get.textScaleFactor * 17)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.list_alt_outlined,
                              ),
                            ),
                            'Lists'
                                .text
                                .wordSpacing(3)
                                .fontWeight(FontWeight.w600)
                                .minFontSize(Get.textScaleFactor * 17)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.bookmark),
                            ),
                            'Bookmarks'
                                .text
                                .wordSpacing(3)
                                .fontWeight(FontWeight.w600)
                                .minFontSize(Get.textScaleFactor * 17)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.topic_outlined,
                              ),
                            ),
                            'Topics'
                                .text
                                .wordSpacing(3)
                                .fontWeight(FontWeight.w600)
                                .minFontSize(Get.textScaleFactor * 17)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async{
                        await GetStorage().remove('userLogin');
                        postProvider.clearMemory();
                        Get.offAllNamed('/signinpage');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.logout_outlined),
                            ),
                            'Log Out'
                                .text
                                .color(kaccentColor)
                                .wordSpacing(3)
                                .fontWeight(FontWeight.w600)
                                .minFontSize(Get.textScaleFactor * 17)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                // InkWell(
                //     onTap: () {},
                //     child: Container(
                //         height: Get.height * 0.07,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: Colors.amber,
                //         ),
                //         child: 'Change Color Theme'
                //             .text
                //             .minFontSize(Get.textScaleFactor * 16)
                //             .bold
                //             .letterSpacing(1.5)
                //             .makeCentered()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
