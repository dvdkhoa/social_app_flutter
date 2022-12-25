import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ltp/providers/common_provider.dart';
import 'package:ltp/providers/custom_posts.dart';
import 'package:ltp/providers/navbar.dart';
import 'package:ltp/providers/post_temp.dart';
import 'package:ltp/utils/constants.dart';
import 'package:ltp/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ltp/providers/custom_notification.dart';

main() async {
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routingClass = RoutingPages();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NavBarProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PostsProvider(),
          ),
          ChangeNotifierProvider(
              create: (context) => PostProvider()
          ),
          ChangeNotifierProvider(
              create: (context) => CommonProvider()
          ),
          ChangeNotifierProvider(
              create: (context) => NotiProvider()
          )
        ],
        child: GetMaterialApp(
          theme: ThemeData(primarySwatch: kmainColor),
          debugShowCheckedModeBanner: false,
          initialRoute: '/splashpage',
          getPages: routingClass.pages,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
