import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_login.dart';


class CommonProvider  extends ChangeNotifier {
  late User _user;

  User get getUser{
    _user = User.fromJson( GetStorage().read('userLogin'));
    return _user;
  }

  void setUser(User user){
    _user = user;
    GetStorage().write('userLogin', _user.toJson());
    notifyListeners();
  }
}