import 'package:get/get.dart';
import 'package:ltp/providers/inbox_provider.dart';
import 'package:ltp/screens/auth/signup.dart';
import 'package:ltp/screens/main/home.dart';
import 'package:ltp/screens/utility/comments.dart';

import 'package:ltp/screens/utility/msgs.dart';
import 'package:ltp/screens/main/post.dart';
import 'package:ltp/screens/main/wrapper.dart';
import 'package:ltp/screens/splash.dart';

import 'package:provider/provider.dart';

import '../screens/auth/signin.dart';
import '../screens/main/change_avata.dart';
import '../screens/main/inbox.dart';
import '../screens/main/myprofile.dart';
import '../screens/main/notifications.dart';
import '../screens/main/post_edit.dart';
import '../screens/main/profile.dart';
import '../screens/main/search.dart';
import '../widgets/custom_comments.dart';

class RoutingPages {
  List<GetPage<dynamic>> pages = [
    GetPage(
      name: '/splashpage',
      page: () => const SplashPage(),
    ),
    GetPage(
      name: '/signinpage',
      page: () => SignInPage(),
    ),
    GetPage(
      name: '/signuppage',
      page: () => SignUpPage(),
    ),
    GetPage(
      name: '/wrapper',
      page: () => WrapperManager(),
    ),
    GetPage(
      name: '/homepage',
      page: () => const HomePage(),
    ),
    GetPage(
      name: '/postpage',
      page: () => const PostScreen(),
    ),
    GetPage(
      name: '/editpostpage',
      page: () => const EditPostScreen(),
    ),
    GetPage(
      name: '/profilepage',
      page: () => ProfilePage(),
    ),
    GetPage(
      name: '/myprofilepage',
      page: () => myProfilePage(),
    ),
    GetPage(
      name: '/searchpage',
      page: () => const SearchPage(),
    ),
    GetPage(
      name: '/notificationspage',
      page: () => const NotificationsPage(),
    ),
    GetPage(
      name: '/inboxpage',
      page: () => const InboxPage(),
    ),

    GetPage(
      name: '/changeavata',
      page: () => const ChangeAvata(),
    ),

    GetPage(
      name: '/commentspage',
      page: () => CustomCommentsPage(),
    ),
    GetPage(
      name: '/msgspage',
      page: () => ChangeNotifierProvider(
          create: (context) => InboxProvider(), child: const MsgsScreen()),
    ),
  ];
}
