import 'package:dio/dio.dart';
// import 'package:ltp/models/usermodel.dart';
import '../models/notification_model.dart';
class NotifyService{
  Future<List<NotificationModel>> getNotifyFromServer(String userId) async{
    final res = await Dio().get('https://10.0.2.2:7284/api/Get/Noti?userId=$userId');

    final map = Map<String, dynamic>.from(res.data);

    final notifyArr = map['data'] as List;

    List<NotificationModel> notifys = notifyArr.map((e) => NotificationModel.fromJson(e)).toList();

    return notifys;

  }
}