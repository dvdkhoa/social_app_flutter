import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltp/models/postmodel.dart';
import 'package:ltp/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  ImagePicker picker = ImagePicker();

  final userLogin = GetStorage().read("userLogin");


  File? imageFile;
  var formController = TextEditingController();

  Future chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        print('da chon image');
        print(imageFile);
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
    // print(userLogin['userId']);
    dio.FormData formData ;
    if (imageFile != null) {
      // print('imagefile khong null');
      String? fileName = imageFile?.path.split('/').last;

      final file = await dio.MultipartFile.fromFile(imageFile!.path, filename: fileName);

      // print(file);
      // print('filepath: ${imageFile!.path}');

       formData = dio.FormData.fromMap({
        "UserId": userLogin['userId'],
        "Text": formController.text,
        "PhotoFile": file,
      });
    }else {
      // print('imagefile null');

      formData = dio.FormData.fromMap({
        "UserId": userLogin['userId'],
        "Text": formController.text,
      });
    }
    // print('file upload');
    // print(imageFile);

    final res = await dio.Dio().post("https://10.0.2.2:7284/api/Post/CreatePost",
        data: formData,
      //   onSendProgress: (send, total) {
      // // print("send: $send, total: $total");
      //   }
    );

    print(res);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
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
                          padding: EdgeInsets.all(8.0),
                          child: Image.file(
                            imageFile!,
                            width: Get.width * 0.5,
                          ),
                        ),
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
                    // uploadIt();
                    uploadPost();
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
