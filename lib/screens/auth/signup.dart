import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/checkbox.dart';
import 'package:ltp/widgets/custom_input.dart';
import 'package:ltp/widgets/gender.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _fullNameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passWordController = TextEditingController();

  TextEditingController _confirmPassWordController = TextEditingController();

  TextEditingController _imageController = TextEditingController();

  DateTime? _birthday = null;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/main_icon.png',
                  color: kMainColor,
                  scale: 3.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: 'Create an Account'
                      .text
                      .minFontSize(24)
                      .fontWeight(FontWeight.w600)
                      .maxFontSize(26)
                      .make(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: 'Sign Up now to get started with your account'
                      .text
                      .minFontSize(18)
                      .make(),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: kMainColor,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/search.png',
                          scale: 20,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        'Sign Up with Google'.text.minFontSize(18).make()
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.black54,
                          //thickness: 1.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: 'OR'.text.make(),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.black54,
                          //thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  title: 'Full Name',
                  textController: _fullNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('Chọn ngày sinh:'),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    Expanded(
                      child: ElevatedButton(

                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime(3000, 12, 31), onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  print('confirm $date');
                                  setState(() {
                                    _birthday = date;
                                  });
                                }, currentTime: DateTime.now(), locale: LocaleType.vi);
                          },
                          child: Text(
                            _birthday == null ?'Click để chọn' : formatter.format(_birthday!),
                            // style: TextStyle(color: Colors.blue),
                          )),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chọn giới tính:'),
                    ListTile(
                      leading: Radio<String>(
                        value: 'male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Male'),
                    ),
                    ListTile(
                      leading: Radio<String>(
                        value: 'female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Female'),
                    ),
                  ],
                ),
                // GenderRadioGroup(),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  title: 'Email Address',
                  textController: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  title: 'Image',
                  textController: _imageController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  title: 'Password',
                  isPassword: true,
                  textController: _passWordController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  title: 'Confim Password*',
                  isPassword: true,
                  textController: _confirmPassWordController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CheckBoxx(),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              'I have agreed to'
                                  .text
                                  .fontWeight(FontWeight.w600)
                                  .make(),
                              ' Terms of Services'
                                  .text
                                  .color(
                                    const Color.fromARGB(255, 4, 25, 219),
                                  )
                                  .fontWeight(FontWeight.w600)
                                  .make(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleRegister(context);
                    // Get.offAllNamed('/wrapper');
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: 'Get Started'
                          .text
                          .minFontSize(18)
                          .fontWeight(FontWeight.w600)
                          .make(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      'Already have an account?'.text.minFontSize(16).make(),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: (() => Get.back()),
                        child: 'Sign In'
                            .text
                            .fontWeight(FontWeight.w500)
                            .minFontSize(16)
                            .color(
                              const Color.fromARGB(255, 8, 12, 236),
                            )
                            .make(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegister(BuildContext context) async{
    Dio dio = Dio();
    final data = {
      "name": _fullNameController.text,
      "email": _emailController.text,
      "password": _passWordController.text,
      "gender": _selectedGender,
      "birthDay": formatter.format(_birthday!),
      "image": _imageController.text
    };

    print(data);
    final res = await dio.post('https://10.0.2.2:7284/api/Account',
        data: data);

    if(res.statusCode == 200) {
      // final res = await dio.post('https://10.0.2.2:7284/api/Account/Login',
      //     data: {
      //       "userName": _emailController.text,
      //       "password": _passWordController.text
      //     });
      // if(res.statusCode == 200) {
      //
      //   final jsonMap = json.decode(res.toString());
      //
      //   await GetStorage().write('userLogin', jsonMap['data']);

        // Get.offAllNamed('/wrapper');
        Get.toNamed('/signinpage');
      }
    }
}





