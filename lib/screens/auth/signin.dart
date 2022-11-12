import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltp/providers/common_provider.dart';
import 'package:ltp/screens/main/wrapper.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/widgets/checkbox.dart';
import 'package:ltp/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/user_login.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    final commonProvider = Provider.of<CommonProvider>(context, listen: false);


    void _handleLogin(context) async{
      try{
        Dio dio = Dio();
        final res = await dio.post('https://10.0.2.2:7284/api/Account/Login',
            data: {
              "userName": _emailController.text,
              "password": _passwordController.text
            });
        if(res.statusCode == 200) {

          final jsonMap = json.decode(res.toString());

          commonProvider.setUser(User.fromJson(jsonMap['data']));

          // GetStorage().write('userLogin', jsonMap['data']);
        }

        // print(GetStorage().read('userLogin'));
        Get.to(WrapperManager());
        // Get.toNamed('/wrapper');
      } on DioError catch(e){
        const snackBar = SnackBar(
          content: Text('Đăng nhập thất bại! :'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

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
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: 'Log in to your Account'
                      .text
                      .minFontSize(24)
                      .fontWeight(FontWeight.w600)
                      .maxFontSize(26)
                      .make(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: 'Welcome back, please enter your details'
                      .text
                      .minFontSize(18)
                      .make(),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
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
                        'Continue with Google'.text.minFontSize(18).make()
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                  height: 20,
                ),
                CustomInput(
                  textController: _emailController,
                  title: 'Email Address',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInput(
                  textController: _passwordController,
                  title: 'Password',
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CheckBoxx(),
                          'Remember Me'.text.make(),
                        ],
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: 'Forgot Password?'
                              .text
                              .fontWeight(FontWeight.w600)
                              .make(),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    // Get.offAllNamed('/wrapper');
                    _handleLogin(context);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: 'Log in'
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
                      'Don\'t have an account?'.text.minFontSize(16).make(),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: (() => Get.toNamed('/signuppage')),
                        child: 'Sign Up'
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

}
