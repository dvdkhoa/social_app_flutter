import 'package:flutter/material.dart';
class SearchProvider with ChangeNotifier{
  List _users = [];
  addUser(userList) {
    _users = userList;
    notifyListeners();
  }

  getUser(){
    return _users;
  }
}