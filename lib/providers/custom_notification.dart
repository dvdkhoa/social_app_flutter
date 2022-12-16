
import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/notify_service.dart';

class NotiProvider extends ChangeNotifier{
  List<NotificationModel> _notifications = [];
  NotifyService _notifyService = NotifyService();

 Future<void> getNotify(userId) async{
   _notifications = await _notifyService.getNotifyFromServer(userId);
   notifyListeners();
 }

 List<NotificationModel> Notifications() => _notifications;
}