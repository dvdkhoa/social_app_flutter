import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltp/models/usermodel.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notificate}) : super(key: key);
  final NotificationModel notificate;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: (() => Get.toNamed('/msgspage', argumentnts: userinbox)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: Get.height * 0.12,
        width: Get.width,
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  notificate.profileImage,
                ),
                radius: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  notificate.title.text
                      .minFontSize(20)
                      .fontWeight(FontWeight.w700)
                      .make(),
                  const Divider(
                    height: 5,
                  ),
                  notificate.time.text.color(Colors.blue).minFontSize(15).make(),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: 'Time'.text.minFontSize(16).maxFontSize(16).make(),
              child: IconButton(
                onPressed: () {  },
                icon: Icon(Icons.settings_ethernet),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
