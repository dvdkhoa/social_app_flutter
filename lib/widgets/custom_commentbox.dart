import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltp/models/usermodel.dart';
import 'package:ltp/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomCommentBox extends StatelessWidget {
  const CustomCommentBox({Key? key, required this.msg, required this.imageUser, required this.userName})
      : super(key: key);

  final String msg;
  final String imageUser;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              color: kMainColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: ktxtwhiteColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imageUser),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: userName.text
                            .color(ktxtwhiteColor)
                            .minFontSize(15)
                            .fontWeight(FontWeight.w600)
                            .make())
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    FittedBox(
                      child: msg?.text
                          .align(TextAlign.start)
                          .color(Colors.white)
                          .fontWeight(FontWeight.w400)
                          .minFontSize(14)
                          .maxFontSize(16)
                          .make(),
                    ),
                  ],
                ),
              ],
            )),
        const Spacer(),
      ],
    );
  }
}
