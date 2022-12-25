import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/models/notification_model.dart';
import 'package:ltp/widgets/inbox_card.dart';
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      final _notiProvider = Provider.of<NotiProvider>(context, listen: false);
      final user = User.fromJson(GetStorage().read('userLogin'));
      _notiProvider.getNotify(user.userId);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<NotiProvider>(
      builder: (context, value, child) {
        if(value.isLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        return ListView.builder(
          itemCount: value.notifications.length,
          itemBuilder: (context, index) {
            return NotificationCard(notificate: value.notifications[index]);
        },);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // children: [
        //   InboxCard(userinbox: donaldTrump),
        //   NotificationCard(notificate: ,)
        //   InboxCard(user:),
        // ],
        children: [],
      ),
    );
    // return 'Notifications'.text.makeCentered();
  }
}
