import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltp/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class NavBarProvider with ChangeNotifier {

  List _users = [];
  
  int _follower = 0;

  List<String> followings = [];


  int getFollow(){
    return _follower;
  }

  void setFollow(userId) async{
    final res = await Dio().get('https://10.0.2.2:7284/api/Account/GetUser?userId='+userId);

    final map = Map<String, dynamic>.from(res.data);

    final followers = map['followers'] as Map;

    _follower = followers.length;
    notifyListeners();
  }

  void setFollowings(userId) async{
    Dio dio = Dio();
    final res = await dio.post('https://10.0.2.2:7284/api/Account/GetFollowings?userId=${userId}');

    followings = (res.data as List).map((e) => e.toString()).toList();

    print(followings);
    notifyListeners();
  }

  List<String> getFollowings() => followings;

  
  void addAllUser(List users){
    _users = users;
    notifyListeners();
  }

  List getUserList() {
    return _users;
  }

  var search = TextEditingController();

  // ignore: prefer_final_fields
  int _navBarIndex = 0;

  int get nBarindex {
    return _navBarIndex;
  }

  void changeNavBarIndex(int value) {
    _navBarIndex = value;
    notifyListeners();
  }

  Widget getCenteredTopText() {
    switch (_navBarIndex) {
      case 0:
        return 'Home'
            .text
            .color(ktxtwhiteColor)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
            .make();
      case 1:
        // return Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        //   child: TextFormField(
        //     decoration: const InputDecoration(
        //       border: OutlineInputBorder(
        //         gapPadding: 10,
        //       ),
        //     ),
        //   ),
        // );
        return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            border:
                Border.all(width: 2.2, color: Colors.white.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(8),
          ),
          height: Get.height * 0.05,
          child:  Center(
            child: TextField(

              textAlignVertical: TextAlignVertical.bottom,
              onChanged: (value) {
                if(!value.isEmptyOrNull)
                {
                  print(value);
                  Dio dio = Dio();
                  dio.get('https://10.0.2.2:7284/api/Account/SearchUser?userName='+value)
                      .then((res) {
                        List users = res.data;
                        addAllUser(users);
                        print(_users);
                      });
                }
              },
              style: TextStyle(

                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(

                  hintText: 'Search for Anything',
                  hintStyle: TextStyle(

                    color: Color.fromARGB(255, 231, 228, 228),

                  ),
                  border: InputBorder.none),
            ),
          ),
        );
      case 2:
        return 'Notifications'
            .text
            .color(Colors.white)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
            .make();
      default:
        return 'Inbox'
            .text
            .color(Colors.white)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
            .make();
    }
  }
}
