import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ltp/models/postmodel.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/VideoPlayerWidget.dart';
import 'package:ltp/widgets/file_player_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

import '../../providers/custom_posts.dart';
import '../../widgets/asset_player_widget.dart';

// ignore: must_be_immutable
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  late PostsProvider postsProvider;

  bool isUpload = false;

  // ImagePicker picker = ImagePicker();
  FilePicker picker = FilePicker.platform;
  PlatformFile? file;


  late VideoPlayerController videoPlayerController;

  final userLogin = GetStorage().read("userLogin");


  PlatformFile? imageFile;
  var formController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      postsProvider = Provider.of<PostsProvider>(context, listen: false);
    });
  }


  Future chooseImage() async {
    // final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    final result = await picker.pickFiles(
      type: FileType.any
    );
    if(result == null)
      return;

    imageFile = result.files.first;

    setState(() {
      if (imageFile != null) {
        print("typefile");
        print(imageFile!.extension);
        // imageFile = file;
        // // videoPlayerController = VideoPlayerController.file(imageFile!);
        // print('da chon image');
        // print(imageFile);
      } else {
        debugPrint('File not Picked');
      }
    });
  }

  // void uploadIt() async {
  //   var myPostModel = PostModel();
  //   String texty = formController.text;
  //
  //   if (texty.isEmpty && imageFile == null) {
  //     return;
  //   } else {
  //     if (texty.isNotEmpty) {
  //       myPostModel.tweetText = texty;
  //     } else {}
  //     if (imageFile != null) {
  //       myPostModel.tweetImage = imageFile;
  //     } else {}
  //     myPostModel.uploadTime = DateFormat.yMEd().format(DateTime.now());
  //     Get.back(result: myPostModel);
  //   }
  // }

  void uploadPost() async{

    dio.FormData formData ;
    if (imageFile != null) {
      // String? fileName = imageFile?.path.split('/').last;

      final file = await dio.MultipartFile.fromFile(imageFile!.path.toString());

      formData = dio.FormData.fromMap({
        "UserId": userLogin['userId'],
        "Text": formController.text,
        "PhotoFile": file,
      });
    }else {
      formData = dio.FormData.fromMap({
        "UserId": userLogin['userId'],
        "Text": formController.text,
      });
    }
    // print('file upload');
    // print(imageFile);

    context.loaderOverlay.show();

    await postsProvider.creatPost(formData);

    context.loaderOverlay.hide();

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
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
                InkWell(
                  onTap: () {
                    chooseImage();
                  },
                  child: imageFile == null
                      ? Container(
                    margin: const EdgeInsets.only(top: 200),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.upload_outlined,
                            size: 50,
                            color: kMainColor,
                          ),
                          'Select Image'.text.make(),
                        ]),
                  )
                      : Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      // child: FilePlayerWidget(file: imageFile!),
                      child: imageFile!.extension != 'mp4'
                          ? Image.file(File(imageFile!.path.toString()), height: Get.width * 0.8)
                          : FilePlayerWidget(file: File(imageFile!.path.toString())),
                    )
                      // child: Image.file(
                      //   imageFile!,
                      //   width: Get.width * 0.5,
                      // ),
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
                      uploadPost();
                    },
                    child: !isUpload ? 'Upload'
                        .text
                        .minFontSize(20)
                        .fontWeight(FontWeight.w500)
                        .make()
                                    : Text('Loading....')
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.025,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
