
import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/notify_service.dart';

class NotiProvider extends ChangeNotifier{
  List<NotificationModel> _notifications = [];
  final NotifyService _notifyService = NotifyService();

  bool isLoading = false;

 Future<void> getNotify(userId) async{
   isLoading = true;
   notifyListeners();

   _notifications = await _notifyService.getNotifyFromServer(userId);
   isLoading = false;
   notifyListeners();
 }

 List<NotificationModel> get notifications => _notifications;
}