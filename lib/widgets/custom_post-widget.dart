import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:ltp/models/post.dart';
import 'package:ltp/providers/custom_posts.dart';
import 'package:ltp/providers/post_temp.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/asset_player_widget.dart';
import 'package:ltp/widgets/special_icon.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class CustomPostWidget extends StatefulWidget {
  CustomPostWidget({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  PostModel post;
  int index;

  @override
  State<CustomPostWidget> createState() => _CustomPostWidgetState();
}

class _CustomPostWidgetState extends State<CustomPostWidget> {

  late List<Likes> likes;
  late List<Comments> comments;
  late int likeCount;
  late PostsProvider _postsProvider;
  Offset _tapPosition = Offset.zero;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postsProvider = Provider.of<PostsProvider>(context,listen: false);

    final postFile = widget.post.detail?.postFiles;

  }


  void _getTapPosition(TapDownDetails details) {
    print('tap nhe');
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      print(_tapPosition);
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  // _showPopupMenu() async {
  //   final RenderBox referenceBox = context.findRenderObject() as RenderBox;
  //   final RenderObject? overlay =
  //   Overlay.of(context)?.context.findRenderObject();
  //   await showMenu(
  //     context: context,
  //     position: RelativeRect.fromRect(
  //         _tapPosition & Size(40, 40), // smaller rect, the touch area
  //         Offset.zero & overlay?.size // Bigger rect, the entire screen
  //     ),
  //     items: [
  //       PopupMenuItem(
  //         child: Text("Show Usage"),
  //       ),
  //       PopupMenuItem(
  //         child: Text("Delete"),
  //       ),
  //     ],
  //     elevation: 8.0,
  //   );
  // }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  // This function will be called when you long press on the blue box or the image
  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
    Overlay.of(context)?.context.findRenderObject();



    final result = await showMenu(
        context: context,

        // Show the context menu at the tap location
        position:
        // RelativeRect.fromLTRB(200, 150, 100, 100),
        RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: 'edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete'),
          ),

        ]);

    // Implement the logic for each choice here
    switch (result) {
      case 'edit':
      // debugPrint('Add To Favorites');
        Get.toNamed('/editpostpage', arguments: widget.post.id);
        break;
      case 'delete':
        _postsProvider.deletePost(widget.post.id.toString());
        break;

    }
  }

  @override
  Widget build(BuildContext context) {

    final userLogin = GetStorage().read('userLogin');
    bool isLike = false;
    widget.post.likes?.forEach((element) {
      if(userLogin['userId']==element.by!.id){
        isLike = true;
      }
    });

    Future<void> _showShareDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Do you want to share this post ?'),
                  // Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  await _postsProvider.sharePost(widget.post!.id.toString(), userLogin['userId']);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    var timeCreated = DateTime.parse(widget.post.meta!.created.toString());
    var formatter = new DateFormat('yyyy-MMM-dd');
    String timeCreated_formatted = formatter.format(timeCreated);



    List<PostFiles>? postFiles = widget.post.detail?.postFiles;


    // likes = widget.datamodel['likes'];
    // List comments = widget.datamodel['comments'];
    likes = widget.post.likes!;
    comments = widget.post.comments!;

    likeCount = likes.length;
    if(!postFiles!.isEmpty){
      print(postFiles![0].url.toString());
    }

    Widget buildSettingButton() {
      if(userLogin['userId'] == widget.post.by!.id) {
        return GestureDetector(
          onTapDown: (details)  {
            _getTapPosition(details);
            _showContextMenu(context);
          },
          // onLongPress: () async{
          //   _showContextMenu(context);
          // },

          child: Icon(Icons.settings),
        );
      }
      return Container();
    }

    if(widget.post?.share?.originPostId != null){
      return Container(
        padding: EdgeInsets.only(bottom: 10),
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
          children: [
            SizedBox(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 5),
                    child: InkWell(
                      onTap: () {
                        if(userLogin['userId'] == widget.post.by!.id){
                          Get.toNamed("/myprofilepage");
                        }
                        else {
                          Get.toNamed("/profilepage", arguments: widget.post.by!.id);
                        }
                      },
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
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: widget.post.by?.name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: kMainColor,
                                      fontWeight: FontWeight.w700
                                    ),
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text: ' đã chia sẻ',
                                        style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        buildSettingButton()
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                ],
              ),
            ),
            Container(
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
                        child: InkWell(
                          onTap: () {
                            if(userLogin['userId'] == widget.post.share?.originOwner?.id){
                              Get.toNamed("/myprofilepage");
                            }
                            else {
                              Get.toNamed("/profilepage", arguments: widget.post.share?.originOwner?.id);
                            }
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: kaccentColor,
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(widget.post.share!.originOwner?.image.toString() ?? ""),
                              radius: 28,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VxTextBuilder(widget.post.share!.originOwner?.name.toString() ?? "")
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
                                  timeCreated_formatted
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
                      SizedBox(width: 30,),
                      //buildSettingButton()
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
                postFiles?.length == 0
                    ? Container()
                    :  (postFiles![0].fileType == 0
                    ? InkWell(
                  child: Image.network(postFiles![0].url.toString(),
                    // alignment: Alignment.center,
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                  // : AssetPlayerWidget(url: "https://10.0.2.2:7284/" + postFiles![0].url.toString()),
                  onTap: () {
                    showDialog(context: context, builder: (context) => AlertDialog(
                      content: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(postFiles![0].url.toString(),
                            fit: BoxFit.cover,
                            height: 200,)
                        ],
                      ),
                    ));
                  },
                )
                    : InkWell(
                  // child: AssetPlayerWidget(url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                  child: AssetPlayerWidget(url: postFiles![0].url.toString(),),
                  onLongPress: () {
                    showDialog(context: context, builder: (context) => AlertDialog(
                      content: Stack(
                        alignment: Alignment.center,
                        children: [
                          AssetPlayerWidget(url: postFiles![0].url.toString())
                        ],
                      ),
                    ));
                  },
                )
                ) ,
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
                      iconData: isLike ? Icons.heart_broken : Icons.favorite_border_outlined,
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
                          likeCount = map['data']['likeCount'] as int;

                          if(isLike)
                            likes.removeWhere((element) => element.by!.id == userLogin['userId']);
                          else
                            likes.add(Likes(by: By(id: userLogin['userId'])));

                          print('ngan');
                          print(likes);
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
                      val: '',
                      iconData: Icons.repeat,
                      color: kmainColor,
                      doFunction: () {},
                    ),
                    SpecialIcon(
                      val: '',
                      iconData: Icons.share,
                      color: kMainColor,
                      doFunction: () {
                        _showShareDialog();
                      },
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
          ),
    ]
        ),
      );
    }

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
                  child: InkWell(
                    onTap: () {
                      if(userLogin['userId'] == widget.post.by!.id){
                        Get.toNamed("/myprofilepage");
                      }
                      else {
                        Get.toNamed("/profilepage", arguments: widget.post.by!.id);
                      }
                    },
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
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                    timeCreated_formatted
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
                        buildSettingButton(),
                      ],
                    ),
                  ),
                )
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
          postFiles?.length == 0
              ? Container()
              :  (postFiles![0].fileType == 0
                ? InkWell(
                        child: Image.network(postFiles![0].url.toString(),
                          // alignment: Alignment.center,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                    // : AssetPlayerWidget(url: "https://10.0.2.2:7284/" + postFiles![0].url.toString()),
                      onTap: () {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          content: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(postFiles![0].url.toString(),
                                fit: BoxFit.cover,
                                height: 200,)
                            ],
                          ),
                        ));
                      },
                    )
                : InkWell(
                    // child: AssetPlayerWidget(url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                        child: AssetPlayerWidget(url: postFiles![0].url.toString(),),
                    onLongPress: () {
                      showDialog(context: context, builder: (context) => AlertDialog(
                        content: Stack(
                          alignment: Alignment.center,
                          children: [
                            AssetPlayerWidget(url: postFiles![0].url.toString())
                          ],
                        ),
                      ));
                    },
                  )
          ) ,
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
              iconData: isLike ? Icons.heart_broken : Icons.favorite_border_outlined,
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
                  likeCount = map['data']['likeCount'] as int;

                  if(isLike)
                    likes.removeWhere((element) => element.by!.id == userLogin['userId']);
                  else
                    likes.add(Likes(by: By(id: userLogin['userId'])));

                  print('ngan');
                  print(likes);
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
                  val: '',
                  iconData: Icons.repeat,
                  color: kmainColor,
                  doFunction: () {},
                ),
              SpecialIcon(
                  val: '',
                  iconData: Icons.share,
                  color: kMainColor,
                  doFunction: () {
                    _showShareDialog();
                  },
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
