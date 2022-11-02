import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/post.dart';

import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/special_icon.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class CustomPostWidget extends StatefulWidget {
  CustomPostWidget({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  Post post;
  int index;

  @override
  State<CustomPostWidget> createState() => _CustomPostWidgetState();
}

class _CustomPostWidgetState extends State<CustomPostWidget> {

  late List<Likes> likes;
  late List<Comments> comments;
  late int likeCount;


  @override
  Widget build(BuildContext context) {
    print('build');

    List<Photos>? photos = widget.post.detail?.photos;
    // likes = widget.datamodel['likes'];
    // List comments = widget.datamodel['comments'];
    likes = widget.post.likes!;
    comments = widget.post.comments!;

    likeCount = likes.length;

    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kaccentColor.withOpacity(0.25),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
          //border: Border.all(color: kaccentColor.withOpacity(0.2), width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: kaccentColor,
                    child: CircleAvatar(
                      backgroundImage:
                      NetworkImage(widget.post.by!.image ?? ""),
                      radius: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VxTextBuilder(widget.post.by?.name ?? "")
                            .minFontSize(17)
                            .color(kMainColor)
                            .maxFontSize(18)
                            .fontWeight(FontWeight.w700)
                            .make(),
                        // datamodel.user.bio.text
                        //     .minFontSize(12)
                        //     .maxFontSize(13)
                        //     .color(Colors.blue)
                        //     .make(),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: kMainColor,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            widget.post.meta!.created
                                .toString()
                                .text
                                .letterSpacing(1)
                                .minFontSize(10)
                                .maxFontSize(12)
                                .color(Colors.black)
                                .make(),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            child: Divider(
              color: Colors.black38,
            ),
            height: 10,
          ),
          widget.post.detail!.text.toString().isEmptyOrNull
              ? Container()
              : Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: VxTextBuilder(widget.post.detail!.text.toString()).make(),
          ),
          photos!.isEmpty
              ? Container()
              : InkWell(
                  child: Image.network("https://10.0.2.2:7284/" + photos![0].url.toString()),
                  onTap: () {
                    showDialog(context: context, builder: (context) => AlertDialog(
                      content: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network("https://10.0.2.2:7284/" + photos![0].url.toString(),
                            fit: BoxFit.cover,
                            height: 200,)
                        ],
                      ),
                    ));
                  },
                ),
          const SizedBox(
            child: Divider(
              color: Colors.black38,
            ),
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SpecialIcon(
              val: likeCount.toString(),
              iconData: Icons.favorite_border_outlined,
              // ? Icons.favorite_border_outlined
              //     : Icons.favorite,
              color: likes.isEmpty ? kMainColor : kMainColor,
              doFunction: () async {
              // valueprovider.addLiketoPost(index, datamodel.user.name);
                Dio dio = Dio();
                final res = await dio.post("https://10.0.2.2:7284/api/Post/Like",
                data: {
                  "userId": GetStorage().read('userLogin')['userId'],
                  "postId": widget.post.id
                });
                print('hello');

                final map = Map<String,dynamic>.from(res.data);
                print(map);
                setState(() {
                  print('222');
                  likeCount = map['data']['likeCount'] as int;


                  likes.removeWhere((element) => element.by!.id == GetStorage().read('userLogin')['userId']);
                  print(likeCount);
                });
              },
              ),
              SpecialIcon(
                  val: comments.length.toString(),
                  iconData: Icons.comment_outlined,
                  color: kMainColor,
                  doFunction: () {
                    Get.toNamed('/commentspage', arguments: widget.post.id);
                  },
                ),
              SpecialIcon(
                  val: '0',
                  iconData: Icons.repeat,
                  color: kmainColor,
                  doFunction: () {},
                ),
              SpecialIcon(
                  val: '',
                  iconData: Icons.share,
                  color: kMainColor,
                  doFunction: () {},
                )
            ],
          )
          // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //   SpecialIcon(
          //     val: datamodel.comments.length.toString(),
          //     iconData: Icons.comment_outlined,
          //     color: kMainColor,
          //     doFunction: () {
          //       Get.toNamed('/commentspage', arguments: index);
          //     },
          //   ),
          //   // SpecialIcon(
          //   //   val: datamodel.retweets.length.toString(),
          //   //   iconData: Icons.repeat,
          //   //   color: kmainColor,
          //   //   doFunction: () {},
          //   // ),
          //   Consumer<PostsProvider>(
          //     builder: (context, valueprovider, child) => SpecialIcon(
          //       val: datamodel.likes.length.toString(),
          //       iconData: datamodel.likes.isEmpty
          //           ? Icons.favorite_border_outlined
          //           : Icons.favorite,
          //       color: datamodel.likes.isEmpty ? kMainColor : kMainColor,
          //       doFunction: () {
          //         valueprovider.addLiketoPost(index, datamodel.user.name);
          // //       },
          //     ),
          //   ),
          //   SpecialIcon(
          //     val: '',
          //     iconData: Icons.share,
          //     color: kMainColor,
          //     doFunction: () {},
          //   )
          // ]),
        ],
      ),
    );
  }
}
