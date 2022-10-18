import 'package:flutter/material.dart';


class CommonProvider  extends ChangeNotifier {
  List _users = [];

  void addAllUser(List users){
    _users = users;
    notifyListeners();
  }

  List getUserList() {
    return _users;
  }
}