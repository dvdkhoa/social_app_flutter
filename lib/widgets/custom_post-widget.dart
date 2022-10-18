import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltp/models/postmodel.dart';
import 'package:ltp/providers/posts.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/special_icon.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class CustomPostWidget extends StatelessWidget {
  CustomPostWidget({
    Key? key,
    required this.datamodel,
    required this.index,
  }) : super(key: key);
  dynamic datamodel;
  int index;
  @override
  Widget build(BuildContext context) {


    print(datamodel);

    List photos = datamodel['detail']['photos']!;
    List likes = datamodel['likes'];
    List comments = datamodel['comments'];

    print(photos);

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
                      NetworkImage(datamodel['by']['image']),
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
                        VxTextBuilder(datamodel['by']['name'])
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
                            datamodel['meta']['created']
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
          datamodel['detail']['text'].toString().isEmptyOrNull
              ? Container()
              : Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: VxTextBuilder(datamodel['detail']['text']).make(),
          ),
          photos.length == 0
              ? Container()
              // : Image.file(datamodel?['detail']['photos'][0]),
              :Image.network("https://10.0.2.2:7284/"+photos[0]['url']),
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
              val: likes.length.toString(),
              iconData: Icons.favorite_border_outlined,
              // ? Icons.favorite_border_outlined
              //     : Icons.favorite,
              color: likes.isEmpty ? kMainColor : kMainColor,
              doFunction: () {
              // valueprovider.addLiketoPost(index, datamodel.user.name);
              },
              ),
              SpecialIcon(
                  val: comments.length.toString(),
                  iconData: Icons.comment_outlined,
                  color: kMainColor,
                  doFunction: () {
                    Get.toNamed('/commentspage', arguments: datamodel['id']);
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
