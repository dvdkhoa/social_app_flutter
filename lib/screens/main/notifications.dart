import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/usermodel.dart';
import '../../widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notification = NotificationModel(
      title: 'Đặng Trung Tín',
      time: '01/01/19xx',
      profileImage:
      'https://www.reviewjournal.com/wp-content/uploads/2019/08/12603740_web1_12603740-5a17a465803a4e0d899189cbce4251b5.jpg',
      bannerImage:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb4eWdIockxFe4lcwv4f-IQ5PeiDHE3lKR7A&usqp=CAU',
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // InboxCard(userinbox: donaldTrump),
        NotificationCard(notificate: notification,)
        //InboxCard(user:),
      ],
    );
    // return 'Notifications'.text.makeCentered();
  }
}
