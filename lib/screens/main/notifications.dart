import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/user_login.dart';
import '../../widgets/notification_card.dart';
import '../../providers/custom_notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  late NotiProvider _notiProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _notiProvider = Provider.of<NotiProvider>(context, listen: false);
      final user = User.fromJson(GetStorage().read('userLogin'));
    });
  }


  @override
  Widget build(BuildContext context) {
    // final notification = NotificationModel(
    //   title: 'Abcxyz',
    //   time: '20/01/2022',
    //   profileImage:
    //   'https://png.pngtree.com/png-vector/20201208/ourlarge/pngtree-a-bell-with-shadow-png-image_2532776.jpg',
    //   bannerImage:
    //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb4eWdIockxFe4lcwv4f-IQ5PeiDHE3lKR7A&usqp=CAU',
    // );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // InboxCard(userinbox: donaldTrump),
        NotificationCard(notificate: ,)
        //InboxCard(user:),
      ],
    );
    // return 'Notifications'.text.makeCentered();
  }
}
