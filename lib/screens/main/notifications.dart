import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/usermodel.dart';
import '../../widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notification = NotificationModel(
      title: 'Abcxyz',
      time: '20/01/2022',
      profileImage:
      'https://png.pngtree.com/png-vector/20201208/ourlarge/pngtree-a-bell-with-shadow-png-image_2532776.jpg',
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
