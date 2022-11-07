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
class ChangeAvata extends StatefulWidget {
  const ChangeAvata({Key? key}) : super(key: key);

  @override
  State<ChangeAvata> createState() => _PostScreenState();
}

class _PostScreenState extends State<ChangeAvata> {
  int change = Get.arguments;


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


  void uploadPost() async{
    // print(userLogin['userId']);
    dio.FormData? formData ;
    if (imageFile != null) {
      String? fileName = imageFile?.path.split('/').last;

      final file = await dio.MultipartFile.fromFile(imageFile!.path, filename: fileName);

      formData = dio.FormData.fromMap({
        "UserId": userLogin['userId'],
        "PhotoFile": file,
      });
    }
    if(formData != null){
      final res = await dio.Dio().post("",
        data: formData,
      );
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: change == 0 ? 'Change Avatar'.text.make()
                            : 'Change Background'.text.make(),
      ),
      body: SizedBox(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Container(

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
