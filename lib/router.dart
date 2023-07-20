import 'package:disko_001/app_layout_screen.dart';
import 'package:disko_001/features/home/screens/detail_page.dart';
import 'package:disko_001/features/profile/screens/other_user_profile_page.dart';
import 'package:disko_001/features/profile/screens/profile_edit_page.dart';
import 'package:disko_001/features/profile/screens/settings/account_setting_page.dart';
import 'package:disko_001/features/profile/screens/settings/setting_page.dart';
import 'package:disko_001/features/starting/landing_pages/landing_page.dart';
import 'package:disko_001/features/write_post/screens/edit_post_page.dart';
import 'package:disko_001/test.dart';
import 'package:flutter/material.dart';

import 'common/widgets/error_screen.dart';
import 'features/auth/screens/signup_page.dart';
import 'features/chat/screens/chat_screen.dart';
import 'features/profile/screens/settings/change_email_page.dart';
import 'features/report/report_screen.dart';
import 'features/search/screens/search.dart';
import 'features/write_post/screens/write_post_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingPage.routeName:
      return MaterialPageRoute(
        builder: (context) => LandingPage(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(
          itisSignUp: true,
        ),
      );
    case AppLayoutScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AppLayoutScreen(),
      );
    case AccountSettingScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final user = arguments['user'];
      return MaterialPageRoute(
        builder: (context) => AccountSettingScreen(user: user),
      );
    case DetailPage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final postId = arguments['postId'];
      return MaterialPageRoute(
        builder: (context) => DetailPage(postId: postId),
      );
    case TestScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final payload = arguments['postId'];
      return MaterialPageRoute(
        builder: (context) => TestScreen(payload: payload),
      );
    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final peerUid = arguments['peerUid'];
      return MaterialPageRoute(
        builder: (context) => ChatScreen(
          peerUid: peerUid,
        ),
      );
    case EditPostScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final post = arguments['post'];
      return MaterialPageRoute(
        builder: (context) => EditPostScreen(
          post: post,
        ),
      );
    case ReportScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final reportedUid = arguments['reportedUid'];
      final reportedDisplayName = arguments['reportedDisplayName'];
      return MaterialPageRoute(
        builder: (context) => ReportScreen(
          reportedUid: reportedUid,
          reportedDisplayName: reportedDisplayName,
        ),
      );
    case WritePostPage.routeName:
      return MaterialPageRoute(
        builder: (context) => const WritePostPage(),
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    case SettingScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final user = arguments['user'];
      return MaterialPageRoute(
        builder: (context) => SettingScreen(user: user),
      );
    case EmailEditPage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final user = arguments['user'];
      return MaterialPageRoute(
        builder: (context) => EmailEditPage(user: user),
      );
    case OtherUserProfilePage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => OtherUserProfilePage(
          uid: uid,
        ),
      );
    case ProfileEditPage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final user = arguments['user'];
      return MaterialPageRoute(
        builder: (context) => ProfileEditPage(
          user: user,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
