import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:ltp/models/usermodel.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notificate}) : super(key: key);
  final NotificationModel notificate;


  @override
  Widget build(BuildContext context) {

    print(notificate.toJson());

    var timeCreated = DateTime.parse(notificate.created.toString());
    var formatter = new DateFormat('yyyy-MMM-dd');
    String timeCreated_formatted = formatter.format(timeCreated);

    return InkWell(
      // onTap: (() => Get.toNamed('/msgspage', argumentnts: userinbox)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: Get.height * 0.13,
        width: Get.width,
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  notificate.thumbnail.toString(),
                ),
                radius: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // notificate.message.toString().text
                  //     .minFontSize(16)
                  //     .fontWeight(FontWeight.w700)
                  //     .make(),
                  Container(
                    width: Get.width * 0.5,
                    child: RichText(
                      text: TextSpan(text: notificate.message.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  timeCreated_formatted!.text.color(Colors.blue).minFontSize(15).make(),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: 'Time'.text.minFontSize(16).maxFontSize(16).make(),
              child: IconButton(
                onPressed: () {
                  showBottomSheet(context: context, builder: (context) {
                    return BottomAppBar(
                      // clipBehavior: Clip.hardEdge,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 100,
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(onPressed: () {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: Text("Bạn có chắc chắn muốn xóa thông báo này không ?"),
                                  actions: [
                                    TextButton(onPressed: () {

                                    }, child: Text("Yes")),
                                    TextButton(onPressed: Get.back, child: Text("No"))
                                  ],
                                );
                              },);
                            }, child: Text("Xóa thông báo", style: TextStyle(fontSize: 16),)),
                            TextButton(onPressed: () {
                              Get.back();
                            }, child: Text("Đóng sheet", style: TextStyle(fontSize: 16)))
                          ],
                        ),
                      ),
                    );
                  },);
                },
                icon: Icon(Icons.settings_ethernet),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
