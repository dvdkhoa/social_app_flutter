import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltp/models/user_model.dart';
import 'package:ltp/widgets/search_profile.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../providers/navbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  // List<User> users = [];

  // late Future<List<User>> futureUser;

  @override
  void initState() {
    super.initState();
    // futureUser = _getAllUser();
  }

  @override
  Widget build(BuildContext context) {

    final navbarProvider = Provider.of<NavBarProvider>(context, listen: true);

    final user = navbarProvider.getUserList();

    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.05,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: 'People You may Know'
                .text
                .minFontSize(18)
                .letterSpacing(1.5)
                .fontWeight(FontWeight.w500)
                .makeCentered(),
          ),
        ),
        Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              // children: List.generate(50, (index) {
              //   return index % 2 == 0
              //       ? ElasticInLeft(
              //           child: const SearchProfile(),
              //         )
              //       : ElasticInRight(
              //           child: const SearchProfile(),
              //         );
              // }),
              children: List.generate(user.length, (index) {
                return index % 2 == 0
                    ? ElasticInLeft(child: SearchProfile(datamodel: user[index]))
                    : ElasticInRight(child: SearchProfile(datamodel: user[index]));
              }),
              // children: Consumer<NavBarProvider>(
              //   builder: (context, navbar_state, child) {
              //     return List.generate(user.length, (index) {
              //       return index % 2 == 0
              //           ? ElasticInLeft(child: SearchProfile())
              //           : ElasticInRight(child: SearchProfile());
              //     });
              //   },
              // )
            ),
          ),
      ],
    );
  }

  // Future<List<User>> _getAllUser() async {
  //   Dio dio = Dio();
  //
  //   final res = await dio.get('https://10.0.2.2:7284/api/Account/GetAllUser');
  //   // final data = json.decode(res.data);
  //   if(res.statusCode == 200){
  //     // print('res: ${res.data['users'].runtimeType}');
  //     // return res.data['users'];
  //     print(res.data['users']);
  //     Iterable l = json.decode(res.data);
  //     List<User> users = List<User>.from(l.map((user)=> User.fromJson(user)));
  //     print('count: '+users.count().toString());
  //     return users;
  //   } else {
  //     throw Exception('Fail');
  //   }
  // }
}
